# 
#   test_application.rb
#   Twitter2MixiVoice
#   
#   Created by kazuya kawaguchi on 2009-11-03.
#   Copyright 2009 kazuya kawaguchi. All rights reserved.
# 

require "test/unit"
require "twitter_2_mixi_voice"
require "yaml"
require "stringio"


class TestApplication < Test::Unit::TestCase
  
  
  Settings = YAML.load_file(File.join(File.dirname(__FILE__), "..", "config", "settings.yml"))
  Success, Error = 0, 1
  
  
  # helper method code(s) block ...
  
  def twitter_id; Settings["twitter_account"]["id"]; end
  
  def twitter_password; Settings["twitter_account"]["password"]; end
  
  def mixi_email; Settings["mixi_account"]["email"]; end
  
  def mixi_password; Settings["mixi_account"]["password"]; end
  
  def run_application(params)
    
    org_stdout = $stdout
    org_stderr = $stderr
    fake_stdout = StringIO.new
    fake_stderr = StringIO.new
    
    result = nil
    begin
      result = Twitter2MixiVoice::Application.run(params)
    ensure
      $stdout = org_stdout
      $stderr = org_stderr
    end
    
    @stdout = fake_stdout.string
    @stderr = fake_stderr.string

    result
  end
  
  # ... helper method code(s)
  
  
  # test code(s) block ...
  
  def test_run_auth_option
    
    options = []
    options << ["-t", twitter_id, "-T", twitter_password, "-m", mixi_email, "-M", mixi_password]  # short
    options << ["--twitter_id", twitter_id, "--twitter_password", twitter_password, "--mixi_email", mixi_email, "--mixi_password", mixi_password] # long
    options.each do |option|
      assert_equal(Twitter2MixiVoice::Success, run_application(option))
    end
  end
  
  
  def test_run_none_password_auth_option
    option = ["-t", twitter_id, "--mixi_email", mixi_email]
    assert_equal(Twitter2MixiVoice::Error, run_application(option))
  end
  
  
  def test_run_version_option
    options = [["-v"], ["--version"]] # short & long
    options.each do |option|
      assert_equal(Twitter2MixiVoice::Success, run_application(option))
    end
  end
  
  
  def test_run_help_option
    options = [["-h"], ["--help"]] # short & long
    options.each do |option|
      assert_equal(Twitter2MixiVoice::Error, run_application(option))
    end
  end
  
  
  def test_run_option_invalid_undefine
    assert_equal(Twitter2MixiVoice::Error, run_application([] << "--invalied"))
  end
  
  
  def test_run_option_empty
    assert_equal(Twitter2MixiVoice::Error, run_application([]))
  end
  
  
  def test_posted_tweets_data
    file_path = File.join(ENV["HOME"], ".twitter2mixivoice", "posted_tweets.yml")
    run_application(["--twitter_id", twitter_id, "--twitter_password", twitter_password, "--mixi_email", mixi_email, "--mixi_password", mixi_password])
    assert(FileTest.exist?(file_path))
  end
  
  # ... test code(s) block
  
  
end # end of 'TestApplication'
