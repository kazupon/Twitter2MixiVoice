# 
#   test_twitter_client.rb
#   Twitter2MixiVoice
#   
#   Created by kazuya kawaguchi on 2009-11-03.
#   Copyright 2009 kazuya kawaguchi. All rights reserved.
# 

require "test/unit"
require "twitter_2_mixi_voice"
require "yaml"


class TestTwitterClient < Test::Unit::TestCase
  
  
  Settings = YAML.load_file(File.join(File.dirname(__FILE__), "..", "config", "settings.yml"))
  
  
  # helper method code(s) block ...
  
  def id; Settings["twitter_account"]["id"]; end
  
  def password; Settings["twitter_account"]["password"]; end
  
  def create_twitter(id, password)
    Twitter2MixiVoice::TwitterClient.new(id, password)
  end
  
  # ... helper method code(s) block
  
  
  # test code(s) block ...
  
  def test_initialize
    twitter = create_twitter(self.id, self.password)
    assert_not_nil(twitter)
    twitter
  end
  
  
  def test_initialize_param_error
    
    assert_raise(Twitter2MixiVoice::TwitterException) { create_twitter("", "") }
    assert_raise(Twitter2MixiVoice::TwitterException) { create_twitter(self.id, "") }
    assert_raise(Twitter2MixiVoice::TwitterException) { create_twitter("", self.password) }
    assert_raise(Twitter2MixiVoice::TwitterException) { create_twitter(self.id, nil) }
    assert_raise(Twitter2MixiVoice::TwitterException) { create_twitter(nil, self.password) }
    
  end
  
  
  def test_initialize_auth_error
    assert_raise(Twitter2MixiVoice::TwitterException) { create_twitter("hoge", "hoge") }
  end
  
  
  def test_get_tweets_from_timeline
    twitter = test_initialize
    tweets = twitter.get_tweets_from_timeline
    assert_not_nil(tweets)
    tweets.each do |tweet|
      assert_not_nil(tweet.id)
      assert_not_nil(tweet.text)
      assert(Time.now > tweet.created_at)
      puts("id = #{tweet.id}, text = #{tweet.text}, created_at = #{tweet.created_at}")
    end
  end
  
  # ... test code(s) block
  
  
end # end of 'TestTwitterClient'
