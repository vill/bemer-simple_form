# frozen_string_literal: true

require 'bemer'
require 'simple_form'
require 'active_support'
require 'active_support/dependencies/autoload'
require 'active_support/lazy_load_hooks'

module Bemer
  module SimpleForm
    extend ActiveSupport::Autoload

    autoload :Builder
    autoload :Configuration
    autoload :Inputs

    module Test
      autoload :ConfigurationHelpers, 'bemer/simple_form/test/configuration_helpers'
    end

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

ActiveSupport.on_load :action_view do
  ::SimpleForm::FormBuilder.send :prepend, Bemer::SimpleForm::Builder
  ::SimpleForm::Inputs::Base.send :prepend, Bemer::SimpleForm::Inputs
end
