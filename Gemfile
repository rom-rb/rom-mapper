# encoding: utf-8

source 'https://rubygems.org'

gemspec

gem 'adamantium', '~> 0.1',   git: 'https://github.com/dkubb/adamantium.git', branch: 'master'
gem 'axiom',      '~> 0.1',   git: 'https://github.com/dkubb/axiom.git',      branch: 'master'
gem 'anima',      '~> 0.2',   git: 'http://github.com/mbj/anima.git',         branch: 'master'
gem 'ducktrap',   '~> 0.0.2', git: 'http://github.com/mbj/ducktrap.git',      branch: 'master'

group :test do
  gem 'bogus', '~> 0.1'
  gem 'rubysl-bigdecimal', :platforms => :rbx
end

group :development do
  gem 'devtools', git: 'https://github.com/rom-rb/devtools.git', branch: 'master'
end

# Added by devtools
eval_gemfile 'Gemfile.devtools'
