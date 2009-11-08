# 
#   twitter_client.rb
#   Twitter2MixiVoice
#   
#   Created by kazuya kawaguchi on 2009-11-03.
#   Copyright 2009 kazuya kawaguchi. All rights reserved.
# 

require "rubygems"
require "twitter"
require "tweet"


module Twitter2MixiVoice
  
  
  # This exception class that is thrown when an errors occur in TwitterClient class.
  class TwitterException < Exception ; end # end of 'TwitterException'
  
  
  # This class provides twitter functions.
  class TwitterClient
    
    
    # Create TwitterClient class instance.
    def initialize(id, password)
      
      # check parameter.
      raise TwitterException.new("Invalid 'id' parameter.") if id.nil? || id.empty?
      raise TwitterException.new("Invalid 'password' password.") if password.nil? || password.empty?
      
      # login to twitter.
      begin
        @client = Twitter::Client.new(:login => id, :password => password)
      rescue Exception => e
        raise TwitterException.new(e.to_s)
      end
      
      # check authenticate.
      unless @client.authenticate?(id, password)
        raise TwitterException.new("Not authenticate.")
      end
      
    end
    
    
    # Get tweets from timeline.
    def get_tweets_from_timeline
      
      # initialize tweets
      tweets = []
      
      # add that get status from timeline in tweet collection.
      begin
        
        # insert status in tweet collection.
        @client.timeline_for(:me) do |status|
          tweet = Tweet.new
          tweet.id = status.id.to_i
          tweet.text = status.text
          tweet.created_at = status.created_at
          tweets << tweet
        end
        
        # sort tweet collection.
        unless tweets.empty?
          tweets = tweets.sort do |a, b|
            a.created_at.to_f <=> b.created_at.to_f
          end
        end
        
      rescue Exception => e
        raise TwitterException.new(e.to_s)
      end
      
      # return tweets.
      tweets
      
    end
    
    
  end # end of 'TwitterClient'
  
  
end # end of 'Twitter2MixiVoice'
