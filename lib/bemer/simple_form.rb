# frozen_string_literal: true

require 'bemer'
require 'simple_form'
require 'active_support/dependencies/autoload'

module Bemer
  module SimpleForm
    extend ActiveSupport::Autoload

    autoload :Builder
    autoload :Configuration

    class << self
      delegate :bemify_suffix_namespaces, :input_type_modifiers_for_suffix_namespaces, to: :config

      def config
        Bemer::SimpleForm::Configuration.instance
      end

      def setup
        yield config
      end
    end
  end
end
