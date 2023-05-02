# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in simple_form-bemer.gemspec
gemspec

gem 'bemer', '>= 0.1.0', '< 1.0', git: 'https://github.com/vill/bemer.git', branch: :master,
                                  ref: 'b1a4cda7e8fe6aae2ad28ca8ad97b61aced220cf'

gem 'fuubar',              '~> 2.5.0'
gem 'rake',                '~> 12.3.0'
gem 'rspec-html-matchers', '~> 0.9.2'
gem 'rspec-rails',         '~> 3.9.0'
gem 'wwtd',                '~> 1.4.1'

unless ENV['CI'] || ENV['APPRAISAL']
  gem 'activesupport',       '~> 6.0.3.1'
  gem 'appraisal',           '~> 2.2.0'
  gem 'bundler',             '~> 1.16'
  gem 'bundler-audit',       '~> 0.6.1'
  gem 'fasterer',            '~> 0.5.1'
  gem 'overcommit',          '~> 0.48.0'
  gem 'rubocop',             '~> 0.70.0'
  gem 'rubocop-performance', '~> 1.3.0'
  gem 'rubocop-rspec',       '~> 1.33.0'
end
