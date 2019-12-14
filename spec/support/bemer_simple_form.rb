# frozen_string_literal: true

RSpec.configure do |config|
  config.before do
    reset_bemer_configuration
    reset_bemer_simple_form_configuration
  end
end
