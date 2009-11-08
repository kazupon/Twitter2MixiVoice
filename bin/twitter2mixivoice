#!/usr/bin/env ruby

# 
#   mixi_voice_bot.rb
#   Twitter2MixiVoice
#   
#   Created by kazuya kawaguchi on 2009-11-08.
#   Copyright 2009 kazuya kawaguchi. All rights reserved.
# 

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "twitter_2_mixi_voice"


#
# entry point
#

if __FILE__ == $0
  
  begin
    # run application.
    Twitter2MixiVoice::Application.run(ARGV)
  rescue Exception => e
    $stderr.puts e.to_s
  end
  
end

__END__
