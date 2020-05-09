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
