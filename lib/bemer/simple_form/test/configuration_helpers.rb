# frozen_string_literal: true

module Bemer
  module SimpleForm
    module Test
      module ConfigurationHelpers
        def reset_bemer_simple_form_configuration(initializer_name = :bemer_simple_form)
          Singleton.send(:__init__, Bemer::SimpleForm::Configuration)

          return unless initializer_name

          begin
            load Rails.root.join('config', 'initializers', "#{initializer_name}.rb")
          rescue LoadError # rubocop:disable Lint/HandleExceptions
          end
        end

        def reset_bemer_simple_form_configuration_and_execute(initializer_name = :bemer_simple_form)
          return unless block_given?

          reset_bemer_simple_form_configuration(initializer_name)

          yield Bemer::SimpleForm.config

          reset_bemer_simple_form_configuration(initializer_name)
        end
      end
    end
  end
end
