# encoding: utf-8

source 'https://rubygems.org'

gemspec

gem 'rom-mapper', path: '.'

gem 'anima',    git: 'http://github.com/mbj/anima.git'
gem 'ducktrap', git: 'http://github.com/mbj/ducktrap.git'

group :test do
  gem 'bogus', '~> 0.1'
  gem 'axiom', '~> 0.1'
end

group :development do
  gem 'devtools', git: 'https://github.com/rom-rb/devtools.git'
end

# Added by devtools
eval_gemfile 'Gemfile.devtools'
