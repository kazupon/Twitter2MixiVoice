# 
#   test_options.rb
#   Twitter2MixiVoice
#   
#   Created by kazuya kawaguchi on 2009-11-04.
#   Copyright 2009 kazuya kawaguchi. All rights reserved.
# 

require "test/unit"
require "twitter_2_mixi_voice"


class TestOptions < Test::Unit::TestCase
  
  
  Version = "1.0.1"
  
  
  # helper method code(s) block ...
  
  def verify_options(params, version = nil)
    params.each do |data, proc|
      options = Twitter2MixiVoice::Options.new(data, version)
      proc.call(options) if proc
    end
  end
  
  # ... helper method code(s) block
  
  
  # test code(s) block ...
  
  def test_help_option
    
    proc = Proc.new do |options|
      assert(options[:show_help])
      assert_match(/Usage:/, options.opts.to_s)
      assert_nil(options[:invalid_argument])
    end
    
    help_options = {}
    help_options[["-h"]] = proc
    help_options[["--help"]] = proc
    
    verify_options(help_options)
    
  end
  
  
  def test_version_option
    
    proc = Proc.new do |options|
      assert(options[:show_version])
      assert_match(/: #{Version}/, options[:show_version])
      assert_nil(options[:invalid_argument])
    end
    
    version_options = {}
    version_options[["-v"]] = proc
    version_options[["--version"]] = proc
    
    verify_options(version_options, Version)
    
  end
  
  
  def test_auth_options
    
    auth_options = {}
    
    auth_options[["--twitter_id", "twitter", "-T", "tweet", "--mixi_email", "user@mixi.jp", "-M", "voice"]] = Proc.new do |options|
      assert_nil(options[:invalid_argument])
      assert_not_nil(options[:twitter_id])
      assert_not_nil(options[:twitter_password])
      assert_not_nil(options[:mixi_email])
      assert_not_nil(options[:mixi_password])
    end
    
    auth_options[["-t", "twitter", "-m", "user@mixi.jp"]] = Proc.new do |options|
      assert_not_nil(options[:invalid_argument])
      assert_not_nil(options[:twitter_id])
      assert_nil(options[:twitter_password])
      assert_not_nil(options[:mixi_email])
      assert_nil(options[:mixi_password])
    end
    
    verify_options(auth_options)
    
  end
  
  
  def test_empty_options
    
    options = {}
    
    options[[""]] = Proc.new do |options|
      assert_not_nil(options[:invalid_argument])
    end
    
    verify_options(options)
    
  end
  
  # ... test code(s) block
  
  
end # end of 'TestOptions'
