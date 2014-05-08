# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "disposable_db/version"

Gem::Specification.new do |s|
  s.name        = "disposable_db"
  s.version     = DisposableDB::VERSION
  s.authors     = ["Keith Larrimore"]
  s.email       = ["keithlarrimore@icehook.com"]
  s.authors     = ['Keith Larrimore']
  s.homepage    = 'https://github.com/klarrimore/disposable_db'
  s.date        = Date.today.to_s
  s.summary     = 'A utility that makes it easy to create "on-the-fly databases"'
  s.description = 'A utility that makes it easy to create "on-the-fly databases"'

  #s.rubyforge_project = "disposable_db"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,bench,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  # specify any dependencies here; for example:
  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rspec', '>= 2.13.0'
  s.add_development_dependency 'ffaker', '~> 1.15.0'
  s.add_development_dependency 'machinist', '~> 2.0'
  s.add_development_dependency 'webmock', '~> 1.9.3'
  s.add_development_dependency 'guard-rspec', '~> 2.5.0'
  s.add_development_dependency 'rb-fsevent', '~> 0.9.3'
  s.add_development_dependency 'simplecov', '~> 0.7.1'
  s.add_runtime_dependency 'sequel', '~> 4.5.0'
  s.add_runtime_dependency 'sqlite3', '~> 1.3.9'
end
