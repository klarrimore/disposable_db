Gem::Specification.new do |s|
  s.name = 'disposable_db'
  s.version = '0.0.1'
  s.date = Date.today.to_s
  s.summary = 'A utility that makes it easy to create "on-the-fly databases"'
  s.description = 'A utility that makes it easy to create "on-the-fly databases"'
  s.authors = ['Keith Larrimore']
  s.email = 'klarrimore@icehook.com'
  s.homepage = 'http:\/\/icehook.com'
  s.add_runtime_dependency 'sequel', ['= 3.33.0']
  s.add_development_dependency 'rspec', ['>= 2.9.0']
  # ensure the gem is built out of versioned files
  s.files = Dir['Rakefile', '{bin,lib,test,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
end
