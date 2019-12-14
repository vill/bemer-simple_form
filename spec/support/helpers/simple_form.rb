# frozen_string_literal: true

module Helpers
  module SimpleForm
    def simple_form_for(record, options = {}, &block)
      view.simple_form_for(record, { url: '', html: { class: '' } }.deep_merge(options), &block)
    end
  end
end
