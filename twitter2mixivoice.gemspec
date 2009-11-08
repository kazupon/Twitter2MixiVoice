# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{twitter2mixivoice}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["kazuya kawaguchi"]
  s.date = %q{2009-11-09}
  s.default_executable = %q{twitter2mixivoice}
  s.description = %q{Post twitter tweet to mixi voice.}
  s.email = %q{kawakazu80@gmail.com}
  s.executables = ["twitter2mixivoice"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "CHANGELOG.rdoc",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/twitter2mixivoice",
     "lib/application.rb",
     "lib/mixi.rb",
     "lib/options.rb",
     "lib/tweet.rb",
     "lib/twitter_2_mixi_voice.rb",
     "lib/twitter_client.rb",
     "test/test_application.rb",
     "test/test_mixi.rb",
     "test/test_options.rb",
     "test/test_tweet.rb",
     "test/test_twitter_2_mixi_voice.rb",
     "test/test_twitter_client.rb",
     "twitter2mixivoice.gemspec"
  ]
  s.homepage = %q{http://github.com/kazupon/Twitter2MixiVoice}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{twitter2mixivoice}
  s.test_files = [
    "test/test_application.rb",
     "test/test_mixi.rb",
     "test/test_options.rb",
     "test/test_tweet.rb",
     "test/test_twitter_2_mixi_voice.rb",
     "test/test_twitter_client.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

