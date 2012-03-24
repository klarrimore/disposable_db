$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'disposable_db/version'

Gem::Specification.new do |s|
  s.name = 'disposable_db'
  s.version = DisposableDB::VERSION
  #s.platform = Gem::Platform::RUBY
  s.date = Date.today.to_s
  s.summary = 'A utility that makes it easy to create "on-the-fly databases"'
  s.description = 'A utility that makes it easy to create "on-the-fly databases"'
  s.authors = ['Keith Larrimore']
  s.email = 'klarrimore@icehook.com'
  s.homepage = 'http:\/\/icehook.com'
  s.add_runtime_dependency 'sequel', ['= 3.33.0']
  s.add_development_dependency 'rspec', ['>= 2.9.0']
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'ffaker', ['>= 1.13.0']
  # ensure the gem is built out of versioned files
  s.files = Dir['Rakefile', '{bin,lib,test,spec,bench}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
  s.require_paths = ["lib"]
end
