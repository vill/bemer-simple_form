# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in simple_form-bemer.gemspec
gemspec

gem 'bemer', '>= 0.1.0', '< 1.0', git: 'https://github.com/vill/bemer.git', branch: :master,
                                  ref: 'b1a4cda7e8fe6aae2ad28ca8ad97b61aced220cf'

# Fix Possible Information Leak / Session Hijack Vulnerability. See: https://github.com/rack/rack/security/advisories/GHSA-hrqr-hxpp-chr3
gem 'rack', '>= 2.0.8'

gem 'bundler', '~> 1.16' unless ENV['CI']
