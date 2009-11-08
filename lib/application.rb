#
#  application.rb
#  mixi_voice_bot
#  
#  Created by kazuya kawaguchi on 2009-10-25.
#  Copyright 2009 kazuya kawaguchi. All rights reserved.
#

require "mixi"
require "twitter_client"
require "options"


module Twitter2MixiVoice
  
  
  # This constants is Twitter2MixiVoice Application return code.
  Success, Error = 0, 1
  
  
  # This class provides mixi bot application.
  class Application
    
    
    # constants
    Posted_Tweets_Dir = File.join(ENV["HOME"], ".twitter2mixivoice")
    Posted_File_Name = "posted_tweets.yml"
    
    
    # Run Application.
    #
    # [<em>*args</em>]
    #   <tt>command line options.</tt>
    #
    def self.run(args)
      
      # parse arguments.
      options = Options.new(args, Twitter2MixiVoice::version)
      
      #
      # check options.
      #
      if options[:invalid_argument]
        $stderr.puts options[:invalid_argument]
        options[:show_help] = true
      end
      
      if options[:show_version]
        $stdout.puts options[:show_version]
        return Success
      end
      
      if options[:show_help]
        $stderr.puts options.opts.to_s
        return Error
      end
      
      
      result = Error
      begin
        
        # login to twitter.
        twitter = login_to_twitter(options[:twitter_id], options[:twitter_password])
        
        # login to mixi.
        mixi = login_to_mixi(options[:mixi_email], options[:mixi_password])
        
        # read cache tweets from YAML file.
        posted_tweets = read_tweets(Posted_Tweets_Dir, Posted_File_Name)
        
        # get tweets from twitter.
        tweets = twitter.get_tweets_from_timeline
        
        # post twitter tweet to mixi voice.
        tweets.each do |tweet|
          if (!posted_tweets.has_key?(tweet.id))
            mixi.post_voice(tweet.text)
            posted_tweets[tweet.id] = tweet
            $stdout.puts "tweet -> voice : id　=　#{tweet.id}, text = #{tweet.text}"
          end
        end
        
        # write YAML file from cache tweets.
        result = write_tweets(Posted_Tweets_Dir, Posted_File_Name, posted_tweets)
        
        result = Success
        
      rescue MixiException => e
        $stderr.puts "Raise MixiException : #{e.to_s}"
        result = Error
      rescue TwitterClientException => e
        $stderr.puts "Raise MixiException : #{e.to_s}"
        result = Error
      rescue Exception => e
        $stderr.puts "Raise Exception : #{e.to_s}"
        result = Error
      end
      
      return result
      
    end # end of 'self.run'
    
    
    # private code(s) block ...
    
    private
    
    def self.login_to_twitter(id, password)
      TwitterClient.new(id, password)
    end
    
    def self.login_to_mixi(email, password)
      Mixi.new(email, password)
    end
    
    def self.read_tweets(dir_path, file_name)
      tweets = {}
      path = File.join(dir_path, file_name)
      File.open(path) { |file| tweets = YAML.load(file) } if FileTest.exist?(path)
      tweets
    end
    
    def self.write_tweets(dir_path, file_name, tweets)
      Dir.mkdir(dir_path) unless FileTest.exist?(dir_path)
      path = File.join(dir_path, file_name)
      File.open(path, "w+") { |file| YAML.dump(tweets, file) }
    end
    
    # ... private code(s) block
    
    
  end # end of 'Application'
  
  
end # end of 'Twitter2MixiVoice'
