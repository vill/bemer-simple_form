# frozen_string_literal: true

module Helpers
  module SimpleForm
    def simple_form_for(record, options = {}, &block)
      options = { url: '', html: { class: nil } }.deep_merge(options)

      view.simple_form_for(record, options, &(block || proc {}))
    end
  end
end
