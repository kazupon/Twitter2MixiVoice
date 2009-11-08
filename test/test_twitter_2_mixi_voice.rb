# 
#   test_twitter_2_mixi_voice.rb
#   Twitter2MixiVoice
#   
#   Created by kazuya kawaguchi on 2009-11-04.
#   Copyright 2009 kazuya kawaguchi. All rights reserved.
# 

require "test/unit"
require "twitter_2_mixi_voice"


class TestTwitter2MixiVoice < Test::Unit::TestCase
  
  def test_version
    assert_not_nil(Twitter2MixiVoice::version)
    puts "Twitter2MixiVoice version : #{Twitter2MixiVoice::version}"
  end
  
end # end of 'TestTwitter2MixiVoice'
