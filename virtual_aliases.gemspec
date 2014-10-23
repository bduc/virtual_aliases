# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "virtual_aliases/version"

Gem::Specification.new do |s|
  s.name        = "virtual_aliases"
  s.version     = VirtualAliases::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Bart Duchesne"]
  s.email       = ["bduc@dyndaco.com"]
  s.homepage    = "https://github.com/bduc/virtual_aliases"
  s.summary     = %q{VirtualAliases}
  s.description = %q{VirtualAliases}
  s.licenses    = ["MIT"]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency 'activerecord', '>=3.1'
  s.add_dependency 'activesupport', '>=3.1'
  s.add_dependency 'arel'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 3.0'

  s.required_ruby_version = ">= 1.9.2"
end
