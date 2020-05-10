# frozen_string_literal: true

RSpec.describe 'simple_form_for helper' do
  it do
    form = simple_form_for :block do |f|
      f.input :elem
    end

    expect(form).to have_tag(:form, with: { class: 'block' }, count: 1) do
      with_tag :div, with: { class: 'block__elem-wrapper' }, count: 1
      with_tag :label, with: { class: 'block__elem-label' }, count: 1
      with_tag :input, with: { class: 'block__elem' }, count: 1
    end
  end

  it do
    form = simple_form_for :form do |f|
      f.button :submit
    end

    expect(form).to have_tag(:form, with: { class: 'form' }, count: 1) do
      with_tag :input, with: { class: 'form__submit' }, count: 1
    end
  end

  it do
    form = simple_form_for :form do |f|
      f.button :button
    end

    expect(form).to have_tag(:form, with: { class: 'form' }, count: 1) do
      with_tag :button, with: { class: 'form__button' }, count: 1
    end
  end

  context 'when the element name is passed through input parameters' do
    it do
      form = simple_form_for :block do |f|
        f.input :elem, elem: nil
      end

      expect(form).to have_tag(:form, with: { class: 'block' }, count: 1) do
        with_tag :div, with: { class: 'block__elem-wrapper' }, count: 1
        with_tag :label, with: { class: 'block__elem-label' }, count: 1
        with_tag :input, with: { class: 'block__elem' }, count: 1
      end
    end

    it do
      form = simple_form_for :block do |f|
        f.input :elem, elem: false
      end

      expect(form).to have_tag(:form, with: { class: 'block' }, count: 1) do
        without_tag 'div[class]'
        without_tag 'label[class]'
        without_tag 'input[class]'
      end
    end

    it do
      form = simple_form_for :block do |f|
        f.input :elem, elem: ''
      end

      expect(form).to have_tag(:form, with: { class: 'block' }, count: 1) do
        without_tag 'div[class]'
        without_tag 'label[class]'
        without_tag 'input[class]'
      end
    end

    it do
      form = simple_form_for :block do |f|
        f.input :elem, elem: :elem_name
      end

      expect(form).to have_tag(:form, with: { class: 'block' }, count: 1) do
        with_tag :div, with: { class: 'block__elem-name-wrapper' }, count: 1
        with_tag :label, with: { class: 'block__elem-name-label' }, count: 1
        with_tag :input, with: { class: 'block__elem-name' }, count: 1
      end
    end

    it do
      form = simple_form_for :block do |f|
        f.input :elem, elem: :elem_name, input_html: { elem: :input }, label_html: { elem: :label }, wrapper_html: { elem: :wrapper }
      end

      expect(form).to have_tag(:form, with: { class: 'block' }, count: 1) do
        with_tag :div, with: { class: 'block__wrapper' }, count: 1
        with_tag :label, with: { class: 'block__label' }, count: 1
        with_tag :input, with: { class: 'block__input' }, count: 1
      end
    end
  end

  context 'when `element_name_transformer` is specified in the configuration' do
    before do
      Bemer::SimpleForm.setup do |config|
        config.element_name_transformer = proc { |namespace, _block, namespaced_elem, initial_elem|
          elem = initial_elem.to_s

          next namespaced_elem unless elem.end_with?('_id', '_ids') || elem.eql?('submit')

          elem =
            if elem.end_with?('_ids')
              elem.chomp('_ids').pluralize
            elsif elem.end_with?('_id')
              elem.chomp('_id')
            else
              :submit_button
            end

          namespace.eql?(:input) ? elem.to_sym : [elem, namespace].compact.join('_').to_sym
        }
      end
    end

    it do
      form = simple_form_for :form do |f|
        f.input :user_ids
      end

      expect(form).to have_tag(:form, with: { class: 'form' }, count: 1) do
        with_tag :div, with: { class: 'form__users-wrapper' }, count: 1
        with_tag :label, with: { class: 'form__users-label' }, count: 1
        with_tag :input, with: { class: 'form__users' }, count: 1
      end
    end

    it do
      form = simple_form_for :form do |f|
        f.input :user_id
      end

      expect(form).to have_tag(:form, with: { class: 'form' }, count: 1) do
        with_tag :div, with: { class: 'form__user-wrapper' }, count: 1
        with_tag :label, with: { class: 'form__user-label' }, count: 1
        with_tag :input, with: { class: 'form__user' }, count: 1
      end
    end

    it do
      form = simple_form_for :form do |f|
        f.button :submit
      end

      expect(form).to have_tag(:form, with: { class: 'form' }, count: 1) do
        with_tag :input, with: { class: 'form__submit-button' }, count: 1
      end
    end
  end
end
