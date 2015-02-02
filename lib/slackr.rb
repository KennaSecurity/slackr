require "slackr/version"
require "slackr/errors"
require "slackr/connection"
require "slackr/webhooks/incoming"
require "slackr/webhooks/attachment_formatter"
require "slackr/channel"
require "slackr/file_uploader"

# slack = Slackr.connect("teamX", "token124", {"channel" => "#myroom", "username" => "systems_bot"})
# slack.say "hello world" => posts 'hello world' to the myroom channel as the systems_bot user
# slack.say "hello", {"channel" => "#room2", "username" => "joke_bot"} => posts 'hello' to the room2 channel as the joke_but user
# slack.upload "/path/to/a/file.txt", {"channels" => "X026VKGP7"} => uploads a file to the channel specified by ID
# slack.channels.list => returns a hash of channel objects
module Slackr
  extend self

  attr_accessor :connection

  def connect(team, token, options = {})
    raise Slackr::ArgumentError, "Team required"  if team.nil?
    raise Slackr::ArgumentError, "Token required" if token.nil?
    #TODO: raise error if options doesn't contain channel and username values
    @connection = Slackr::Connection.new(team, token, options).init
    return self
  end

  def say(text, options = {})
    Slackr::IncomingWebhook.say(connection, text, options)
  end

  def upload(filepath, options = {})
    Slackr::FileUploader.new(connection, filepath, options).upload
  end

  def channels
    Slackr::Channel.init(connection)
  end

  # support for backwards compatibility
  class Webhook
    def initialize(team, token, options = {})
      warn "[DEPRECATION] `Slackr::Webhook.new` is deprecated.  Please use `Slackr.connect` instead."
    end
  end
end

