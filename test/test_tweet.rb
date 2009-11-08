# 
#   test_tweet.rb
#   Twitter2MixiVoice
#   
#   Created by kazuya kawaguchi on 2009-11-03.
#   Copyright 2009 kazuya kawaguchi. All rights reserved.
# 

require "test/unit"
require "twitter_2_mixi_voice"


class TestTweet < Test::Unit::TestCase
  
  
  def test_tweet
    
    tweet = Twitter2MixiVoice::Tweet.new
    tweet.id = 12345
    tweet.text = "hello world."
    tweet.created_at = Time.now
    
    assert_equal(12345, tweet.id)
    assert_equal("hello world.", tweet.text)
    assert(Time.now > tweet.created_at)
    
    tweet
    
  end
  
  
end # end of 'TestTweet'
