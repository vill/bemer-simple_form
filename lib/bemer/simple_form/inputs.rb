# frozen_string_literal: true

require 'active_support/core_ext/array/wrap'
require 'active_support/core_ext/object/blank'

module Bemer
  module SimpleForm
    module Inputs
      def initialize(builder, attribute_name, column, input_type, options = {})
        super

        bemify_input!
      end

      protected

      def block_entity
        @block_entity ||= @options.delete(:block_entity)
      end

      def bemify_input! # rubocop:disable Metrics/AbcSize
        return unless block_entity

        default_name = options.delete(:elem)

        Bemer::SimpleForm.bemify_suffix_namespaces.each do |namespace|
          elem    = extract_elem_name_for!(namespace, default_name)
          options = extract_bem_options_for!(namespace)

          add_input_type_modifiers!(namespace, options)

          elem_entity = ::Bemer::EntityBuilder.new(block_entity.block, elem, options)

          bem_options_for(namespace).merge!(elem_entity.attrs).delete(:block)
        end
      end

      # rubocop:disable Metrics/LineLength
      def extract_elem_name_for!(namespace, default_name) # rubocop:disable Metrics/AbcSize
        elem = bem_options_for(namespace).delete(:elem)

        return Bemer::SimpleForm.transform_element_name(namespace, block_entity.block, elem, elem) unless elem.nil?

        elem = default_name.nil? ? reflection_or_attribute_name : default_name

        return Bemer::SimpleForm.transform_element_name(namespace, block_entity.block, elem, elem) if Bemer.bem_class(block_entity.block, elem).blank?

        suffix = namespace.to_s.chomp('_html') unless namespace.eql?(:input_html)

        namespaced_elem = [elem, suffix].compact.join('_').to_sym

        Bemer::SimpleForm.transform_element_name(namespace, block_entity.block, namespaced_elem, elem)
      end
      # rubocop:enable Metrics/LineLength

      def add_input_type_modifiers!(namespace, options)
        return if Bemer::SimpleForm.input_type_modifiers_for_suffix_namespaces.exclude?(namespace)

        options[:mods] = Array.wrap(options[:mods])

        options[:mods].push(*additional_classes)
      end

      def bem_options_for(namespace)
        namespace.eql?(:input_html) ? @input_html_options : @options[namespace] ||= {}
      end

      def extract_bem_options_for!(namespace)
        bem_options = bem_options_for(namespace)
        bem         = bem_options.delete(:bem)
        bem_cascade = extract_bem_cascade!(bem_options)
        css_classes = [bem_options.delete(:cls), bem_options.delete(:class)]
        js          = bem_options.delete(:js)
        mix         = bem_options.delete(:mix)
        mods        = bem_options.delete(:mods)

        { bem: bem, js: js, mods: mods, mix: mix, bem_cascade: bem_cascade, cls: css_classes }
      end

      def extract_bem_cascade!(options)
        bem_cascade = options.delete(:bem_cascade)

        bem_cascade.nil? ? block_entity.instance_variable_get(:@bem_cascade) : bem_cascade
      end
    end
  end
end
