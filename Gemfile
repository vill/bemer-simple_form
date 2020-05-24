# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in simple_form-bemer.gemspec
gemspec

gem 'bemer', '>= 0.1.0', '< 1.0', git: 'https://github.com/vill/bemer.git', branch: :master,
                                  ref: 'b1a4cda7e8fe6aae2ad28ca8ad97b61aced220cf'

unless ENV['CI'] || ENV['APPRAISAL']
  gem 'activesupport', '~> 6.0.3.1'
  gem 'bundler',       '~> 1.16'
  gem 'overcommit',    '~> 0.48.0'
end
