# 
#   test_mixi.rb
#   Twitter2MixiVoice
#   
#   Created by kazuya kawaguchi on 2009-11-03.
#   Copyright 2009 kazuya kawaguchi. All rights reserved.
# 

require "test/unit"
require "twitter_2_mixi_voice"
require "yaml"


class TestMixi < Test::Unit::TestCase
  
  
  Settings = YAML.load_file(File.join(File.dirname(__FILE__), "..", "config", "settings.yml"))
  
  
  # helper methods code block ...
  
  def email; Settings["mixi_account"]["email"]; end
  
  def password; Settings["mixi_account"]["password"]; end
  
  def create_mixi(email, password)
    Twitter2MixiVoice::Mixi.new(email, password)
  end
  
  # ... helper methods code block
  
  
  # tests code block ...
  
  def test_initialize
    mixi = create_mixi(self.email, self.password)
    assert_not_nil mixi
    mixi
  end
  
  
  def test_initialize_param_error
    
    assert_raise(Twitter2MixiVoice::MixiException) { create_mixi("", "") }
    assert_raise(Twitter2MixiVoice::MixiException) { create_mixi(email, "") }
    assert_raise(Twitter2MixiVoice::MixiException) { create_mixi("", password) }
    assert_raise(Twitter2MixiVoice::MixiException) { create_mixi(email, nil) }
    assert_raise(Twitter2MixiVoice::MixiException) { create_mixi(nil, password) }
    
    # TODO: should be special data('/','¥', '\', etc ...) check
    
  end
  
  
  def test_initialize_auth_error
    assert_raise(Twitter2MixiVoice::MixiException) { create_mixi("hoge", "hoge") }
  end
  
  
  def test_add_voice
    mixi = test_initialize
    mixi.post_voice "hello world."
  end
  
  
  def test_add_voice_param_error
    
    mixi = test_initialize
    mixi_voice_max_length = 150
    assert_raise(Twitter2MixiVoice::MixiException) { mixi.post_voice("") }
    assert_raise(Twitter2MixiVoice::MixiException) { mixi.post_voice(nil) }
    assert_nothing_raised(Twitter2MixiVoice::MixiException) { mixi.post_voice("a" * (mixi_voice_max_length - 1)) }
    assert_nothing_raised(Twitter2MixiVoice::MixiException) { mixi.post_voice("a" * mixi_voice_max_length) }
    assert_raise(Twitter2MixiVoice::MixiException) { mixi.post_voice("a" * (mixi_voice_max_length + 1)) }
    assert_nothing_raised(Twitter2MixiVoice::MixiException) { mixi.post_voice("あ" * (mixi_voice_max_length - 1)) }
    assert_nothing_raised(Twitter2MixiVoice::MixiException) { mixi.post_voice("あ" * mixi_voice_max_length) }
    assert_raise(Twitter2MixiVoice::MixiException) { mixi.post_voice("あ" * (mixi_voice_max_length + 1)) }
    
    # TODO: should be special data('/','¥', '\', etc ...) check
    
  end
  
  # ... tests code block
  
  
end # end of 'TestMixi'
