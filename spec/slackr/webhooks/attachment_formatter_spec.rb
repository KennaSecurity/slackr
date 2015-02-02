require 'spec_helper'

describe Slackr::AttachmentFormatter do

  let(:format){
    {
      fallback: "This is a special message.",
      color: "#FFFF",
      pretext: "This text comes before the message",
      author_name: "Adam Hallett",
      author_link: "http://adamhallett.com",
      author_icon: "https://lh4.googleusercontent.com/-eGtN46OfaB4/AAAAAAAAAAI/AAAAAAAAAAA/6QuCpIvxEvA/s32-c/photo.jpg",
      text: "Some text.",
      title: "Ping",
      title_link: "http://server-stats.com",
      fields: [{
                title: "RiskIO",
                value: "staging",
                short: true,
              }],
    }
  }

  before do
    @attachment = Slackr::AttachmentFormatter.new(format)
  end

  it "should set required fallback" do
    @attachment.fallback.should == "This is a special message."
  end

  it "should set required color" do
    @attachment.color.should == format[:color]
  end

  it "should set required author_name" do
    @attachment.author_name.should == format[:author_name]
  end

  it "should set required author_link" do
    @attachment.author_link.should == format[:author_link]
  end

  it "should set required author_icon" do
    @attachment.author_icon.should == format[:author_icon]
  end

  it "should set required title" do
    @attachment.title.should == format[:title]
  end

  it "should set required title_link" do
    @attachment.title_link.should == format[:title_link]
  end

  it "should set required fields" do
    @attachment.fields.should == format[:fields]
  end

  it "should set required text" do
    @attachment.text.should == format[:text]
  end
end