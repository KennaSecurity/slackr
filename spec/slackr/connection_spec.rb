require 'spec_helper'

describe Slackr::Connection do
  describe "#init" do
    before do
      @subject = Slackr::Connection.new('team', 'fakeToken')
    end

    it "should validate the options" do
      expect(@subject).to receive(:validate_options)
      @subject.init
    end

    it "should setup the connection" do
      expect(@subject).to receive(:setup_connection)
      @subject.init
    end
  end

  describe "#base_url" do
    it "should return the complete url with subdomain" do
      subject = Slackr::Connection.new("foo", "bar")
      expect(subject.send(:base_url)).to eq("https://foo.slack.com")
    end
  end

  describe "#uri_request_uri" do
    it "should return the request_url of the uri" do
      subject = Slackr::Connection.new("team", "token", {"channel" => "#foo", "username" => "baz"})
      subject.send(:setup_connection)
      expect(subject.uri_request_uri).to eq("/")
    end
  end

  describe "#http_request" do
    before do
      stub_request(:post, "https://team.slack.com/").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "", :headers => {})

      stub_request(:post, "https://team.slack.com/").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "", :headers => {})
    end

    it "should return the request_url of the http" do
      subject = Slackr::Connection.new("team", "token", {"channel" => "#foo", "username" => "baz"})
      subject.send(:setup_connection)
      request  = Net::HTTP::Post.new(subject.uri_request_uri)
      response = subject.http_request(request)
      expect(response.code).to eq("200")
    end
  end


  describe "#validate_options" do
    before do
      @subject = Slackr::Connection.new('team', 'fakeToken')
    end

    context 'with valid options' do
      it "should return true" do
        options = {
          "channel"  => "#myroom",
          "username" => "my_bot_name"
        }
        @subject.instance_variable_set(:@options, options)
        expect(@subject.send(:validate_options)).to eq(true)
      end
    end

    context 'with invalid options' do
      context 'with improper channel name' do
        it "should return false" do
          options = {
            "channel"  => "foo",
            "username" => "my_bot_name"
          }
          @subject.instance_variable_set(:@options, options)
          expect(@subject.send(:validate_options)).to eq(false)
        end
      end

      context 'with missing username' do
        it "should return false" do
          options = {
            "channel"  => "foo"
          }
          @subject.instance_variable_set(:@options, options)
          expect(@subject.send(:validate_options)).to eq(false)
        end
      end
    end
  end

  describe "#setup_connection" do
    before do
      @subject = Slackr::Connection.new("team", "token", {"channel" => "#foo", "username" => "bot"})
    end

    it "should define the uri instance variable" do
      expect(@subject.uri).to be_nil
      @subject.send(:setup_connection)
      expect(@subject.uri).to_not be_nil
    end

    it "should define the http isntance variable" do
      expect(@subject.http).to be_nil
      @subject.send(:setup_connection)
      expect(@subject.http).to_not be_nil
    end
  end
end

