# 
#   options.rb
#   Twitter2MixiVoice
#   
#   Created by kazuya kawaguchi on 2009-11-04.
#   Copyright 2009 kazuya kawaguchi. All rights reserved.
# 

require "optparse"


module Twitter2MixiVoice
  
  
  # This class provides command line option.
  class Options < Hash


    attr_reader :opts


    def initialize(params, version = nil)
      
      super()
      
      
      @opts = OptionParser.new do |o|
        
        o.on("-t", "--twitter_id TWITTER_ID", "login twitter id") do |id|
          self[:twitter_id] = id
        end
        
        o.on("-T", "--twitter_password TWITTER_PASSWORD", "login twitter passowrd") do |password|
          self[:twitter_password] = password
        end

        o.on("-m", "--mixi_email MIXI_EMAIL", "login mixi email") do |email|
          self[:mixi_email] = email
        end

        o.on("-M", "--mixi_password MIXI_PASSWORD", "login mixi password") do |password|
          self[:mixi_password] = password
        end

        o.on("-h", "--help", "#{File.basename($0, ".*")} help") do |help|
          self[:show_help] = help
        end

        o.on_tail("-v", "--version", "#{File.basename($0, ".*")} version") do
          self[:show_version] = "#{File.basename($0, ".*")}: #{version}"
        end

      end


      begin
        @opts.parse!(params)
      rescue OptionParser::InvalidOption => e
        self[:invalid_argument] = e.message
      rescue OptionParser::InvalidArgument => e
        self[:invalid_argument] = e.message
      rescue OptionParser::MissingArgument => e
        self[:invalid_argument] = e.message
      rescue OptionParser::NeedlessArgument => e
        self[:invalid_argument] = e.message
      rescue OptionParser::ParseError => e
        self[:invalid_argument] = e.message
      rescue Exception => e
        self[:invalid_argument] = e.message
      end
      
      
      # check authorized parameter.
      if self[:show_version].nil? && self[:show_help].nil?
        self[:invalid_argument] = "invalid argument" if self[:twitter_id].nil? || self[:twitter_password].nil? || self[:mixi_email].nil? || self[:mixi_password].nil?
      end
      
    end # end of 'initialize'
    
    
  end # end of 'Options'
  
  
end # end of 'Twitter2MixiVoice'
