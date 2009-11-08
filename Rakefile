require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "Twitter2MixiVoice"
    gem.summary = %Q{Twitter2MixiVoice}
    gem.description = %Q{Post twitter tweet to mixi voice.}
    gem.email = "kawakazu80@gmail.com"
    gem.homepage = "http://github.com/kazupon/Twitter2MixiVoice"
    gem.authors = ["kazuya kawaguchi"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


begin
  
  require "highline"
  desc "Setting test account"
  task :setting_test_account do
    
    setting_dir_path = "config"
    setting_file_path = "#{setting_dir_path}/settings.yml"
    setting_block = Proc.new do
      password_block = Proc.new { |q| q.echo = "*" }
      twitter_id = HighLine.new.ask("Enter Twitter ID: ")
      twitter_pwd = HighLine.new.ask("Enter Twitter Password: ", &password_block)
      mixi_email = HighLine.new.ask("Enter Mixi ID: ")
      mixi_pwd = HighLine.new.ask("Enter Mixi Password: ", &password_block)

      settings = {
        "mixi_account" => {
          "email" => mixi_email,
          "password" => mixi_pwd 
        } ,
        "twitter_account" => {
          "id" => twitter_id,
          "password" => twitter_pwd
        }
      }
      File.open(setting_file_path, "w") { |file| YAML.dump(settings, file) }
    end
    
    if FileTest.exist?(setting_file_path)
      result = HighLine.new.ask("Already Test Account Setting File. ReUse ? Yes -> Enter key, No -> 'n' typing : ")
      if result == "n"
        setting_block.call
        puts "Success : Update '#{setting_file_path}' File."
      end
    else
      Dir.mkdir(setting_dir_path)
      setting_block.call
      puts "Success : Create '#{setting_file_path}' File."
    end
    
  end
  
rescue Exception => e
  puts "Error : Create 'config/settings.yml' File."
end


#task :test => :check_dependencies
task :test => [:check_dependencies, :setting_test_account]

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "Twitter2MixiVoice #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.inline_source = true
  rdoc.options << "-c UTF-8"
end
