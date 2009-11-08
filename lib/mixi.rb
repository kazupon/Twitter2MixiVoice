# 
#   mixi.rb
#   Twitter2MixiVoice
#   
#   Created by kazuya kawaguchi on 2009-11-03.
#   Copyright 2009 kazuya kawaguchi. All rights reserved.
# 

require "rubygems"
require "mechanize"
require "kconv"


module Twitter2MixiVoice
  
  
  # This exception class that is thrown when an errors occur in Mixi class.
  class MixiException < Exception ; end # end of 'MixiException'
  
  
  # This class provides mixi functions.
  class Mixi
    
    
    VOICE_MAX_LENGTH = 150
    
    
    # Create Mixi class instance.
    def initialize(email, password)
      
      # check parameter.
      raise MixiException.new("Invalid 'email' parameter .") if email.nil? || email.empty?
      raise MixiException.new("Invalid 'password' parameter .") if password.nil? || password.empty?
      
      # login to mixi.
      begin
        @agent = WWW::Mechanize.new
        @agent.get("http://mixi.jp")
        @agent.page.form_with(:name => "login_form") do |form|
          form.field_with(:name => "email").value = email
          form.field_with(:name => "password").value = password
          form.submit
        end
      rescue Exception => e
        raise MixiException.new(e.to_s)
      end
      
      # check login error.
      error = @agent.page.at("div#errorArea")
      unless error.nil?
        raise MixiException.new(error.inner_text)
      end
      
    end
    
    
    # Post mixi voice.
    def post_voice(message)
      
      # check parameter
      raise MixiException.new("Invalid 'message' parameter.") if message.nil? || message.empty? || message.split(//u).length > VOICE_MAX_LENGTH
      
      # post voice
      begin
        @agent.get("http://mixi.jp/recent_echo.pl")
        @agent.page.form_with(:action => "add_echo.pl") do |form|
          form.field_with(:name => "body").value = message
          form.click_button
        end
      rescue Exception => e
        raise MixiException.new(e.to_s)
      end
      
    end
    
    
  end # end of 'Mixi'
  
  
end # end of 'Twitter2MixiVoice'