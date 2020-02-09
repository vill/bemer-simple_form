# frozen_string_literal: true

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

      def bemify_input!
        return unless block_entity

        Bemer::SimpleForm.bemify_suffix_namespaces.each do |namespace|
          elem    = extract_elem_name_for!(namespace)
          options = extract_bem_options_for!(namespace)

          add_input_type_modifiers!(namespace, options)

          elem_entity = ::Bemer::EntityBuilder.new(block_entity.block, elem, options)

          bem_options_for(namespace).merge!(elem_entity.attrs).delete(:block)
        end
      end

      def extract_elem_name_for!(namespace)
        bem_options = bem_options_for(namespace)
        elem        = bem_options.delete(:elem)

        return elem unless elem.nil?

        suffix = namespace.to_s.chomp('_html') unless namespace.eql?(:input_html)

        [reflection_or_attribute_name, suffix].compact.join('_').to_sym
      end

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
