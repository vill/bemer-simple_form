# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'

require_relative 'dummy/config/environment'

require 'rspec/rails'
require 'spec_helper'
require 'fuubar'
require 'rspec-html-matchers'
require 'active_support/core_ext/string/inflections'

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!

  config.fuubar_progress_bar_options = {
    format: "Rails: #{::Rails::VERSION::STRING} %c/%C |%w>%i| %e "
  }

  config.define_derived_metadata file_path: %r{/spec/action_view/} do |metadata|
    metadata[:type] = :view
  end

  config.include Bemer::Test::ConfigurationHelpers
  config.include Bemer::SimpleForm::Test::ConfigurationHelpers
  config.include RSpecHtmlMatchers
  config.include Helpers::SimpleForm, type: :view
end
