# encoding: utf-8

require File.expand_path('../lib/rom/mapper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "rom-mapper"
  gem.description   = "rom-mapper"
  gem.summary       = gem.description
  gem.authors       = %[Piotr Solnica Martin Gamsjaeger]
  gem.email         = %[piotr.solnica@gmail.com, gamsnjaga@gmail.com]
  gem.homepage      = 'http://rom-rb.org'
  gem.require_paths = [ 'lib' ]
  gem.version       = ROM::Mapper::VERSION.dup
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")
  gem.license       = 'MIT'

  gem.add_dependency 'concord',  '~> 0.1.4'
  gem.add_dependency 'anima',    '~> 0.1.1'
  gem.add_dependency 'ducktrap', '~> 0.0.2'
end
