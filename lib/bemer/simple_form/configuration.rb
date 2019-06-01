# frozen_string_literal: true

require 'singleton'
require 'active_support/core_ext/array/wrap'

module Bemer
  module SimpleForm
    class Configuration
      include Singleton

      attr_accessor :bemify_namespaces, :input_type_modifiers_for_namespaces

      def initialize
        @bemify_namespaces                   = %i[error hint input wrapper label]
        @input_type_modifiers_for_namespaces = %i[input wrapper label]
      end

      def bemify_suffix_namespaces
        Array.wrap(bemify_namespaces).uniq.map { |n| add_sufix(n) }
      end

      def input_type_modifiers_for_suffix_namespaces
        Array.wrap(input_type_modifiers_for_namespaces).uniq.map { |n| add_sufix(n) }
      end

      protected

      def add_sufix(namespace)
        [namespace, :html].join('_').to_sym
      end
    end
  end
end
