# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'

module Bemer
  module SimpleForm
    module Builder
      def initialize(*)
        super

        extract_block_options!(options)
      end

      def button(type, *args, &block)
        options = args.extract_options!
        elem    = extract_name_for!(:elem, type, options)
        elem    = Bemer::SimpleForm.transform_element_name(nil, block_entity.block, elem, elem)
        entity  = Bemer::EntityBuilder.new(block_entity.block, elem, **extract_bem_options!(options))

        options.delete(:block)

        args << options.merge!(entity.attrs)

        super
      end

      protected

      def block_entity
        @defaults.dig(:block_entity)
      end

      def extract_block_options!(options)
        @defaults      ||= {}
        options        ||= {}
        options[:html] ||= {}

        block = extract_name_for!(:block, object_name, options)

        options.delete(:elem)

        @defaults[:block_entity] = Bemer::EntityBuilder.new(block, **extract_bem_options!(options))

        options[:html].merge!(block_entity.attrs)
      end

      def extract_bem_options!(options)
        bem         = options.delete(:bem)
        bem_cascade = extract_bem_cascade!(options)
        css_classes = [options.delete(:cls), options.delete(:class), options[:html]&.delete(:class)]
        js          = options.delete(:js)
        mix         = options.delete(:mix)
        mods        = options.delete(:mods)

        { bem: bem, js: js, mods: mods, mix: mix, bem_cascade: bem_cascade, cls: css_classes }
      end

      def extract_name_for!(key, default_name, options)
        name = options.delete(key)

        name.nil? ? default_name.to_sym : name
      end

      def extract_bem_cascade!(options)
        bem_cascade = options.delete(:bem_cascade)

        return bem_cascade if block_entity.nil?

        bem_cascade.nil? ? block_entity.instance_variable_get(:@bem_cascade) : bem_cascade
      end
    end
  end
end
