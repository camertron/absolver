$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'absolver/version'

Gem::Specification.new do |s|
  s.name     = 'absolver'
  s.version  = ::Absolver::VERSION
  s.authors  = ['Cameron Dutro']
  s.email    = ['camertron@gmail.com']
  s.homepage = 'http://github.com/camertron/absolver'

  s.description = s.summary = 'Allows setting the cause of Ruby exceptions.'

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  s.require_path = 'lib'
  s.files = Dir['{lib,spec}/**/*', 'Gemfile', 'README.md', 'Rakefile', 'absolver.gemspec']
end
