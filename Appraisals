# frozen_string_literal: true

ENV['APPRAISAL'] = 'true'

SUPPORTED_BEMER_VERSIONS       = %w[0.1.0 0.2.0 0.3.0].freeze
SUPPORTED_SIMPLE_FORM_VERSIONS = %w[0.4.0 0.5.0 1.0.0 1.1.0 1.2.0 1.3.0 1.4.0 1.5.0 2.0.0 2.1.0
                                    3.0.0 3.1.0 3.2.0 3.3.0 3.4.0 3.5.0 4.0.0 4.1.0 5.0.0].freeze

SUPPORTED_SIMPLE_FORM_VERSIONS.each do |simple_form_version|
  SUPPORTED_BEMER_VERSIONS.each do |bemer_version|
    name = "simple_form_#{simple_form_version[0..2]}.x_bemer_#{bemer_version[0..2]}.x"

    appraise name do
      gem 'bemer',       "~> #{bemer_version}"
      gem 'simple_form', "~> #{simple_form_version}"
    end
  end
end
