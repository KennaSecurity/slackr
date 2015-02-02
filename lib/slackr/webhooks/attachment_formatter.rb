module Slackr
  class AttachmentFormatter
    attr_accessor :fallback, :color, :pretext, :author_name,
      :author_link, :author_icon, :title, :title_link, :text,
      :fields

    def initialize( args = {})
      args.each_pair{|k,v| instance_variable_set("@#{k}", v) }
    end

    def as_json
      ret = {}
      ret[:fallback]    = @fallback
      ret[:color]       = @color
      ret[:pretext]     = @pretext
      ret[:author_name] = @author_name
      ret[:author_link] = @author_link
      ret[:author_icon] = @author_icon
      ret[:title]       = @title
      ret[:title_link]  = @title_link
      ret[:text]        = @text
      ret[:fields]      = @fields
      ret
    end
  end
end