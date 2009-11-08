# 
#   twitter_2_mixi_voice.rb
#   Twitter2MixiVoice
#   
#   Created by kazuya kawaguchi on 2009-11-03.
#   Copyright 2009 kazuya kawaguchi. All rights reserved.
# 


# This module is posted tweet of twitter to mixi voice.
module Twitter2MixiVoice
  
  
  require "mixi"
  require "twitter_client"
  require "tweet"
  require "application"
  require "options"
  
  
  # Get +Twitter2MixiVoice+ module version.
  def self.version
    version = nil
    begin
      version_path = File.join(File.dirname(__FILE__), "..", "VERSION")
      version = File.exist?(version_path) ? File.read(version_path) : ""
    rescue Exception => e
      version = ""
    end
    version
  end
  
  
end # end of 'Twitter2MixiVoice'
