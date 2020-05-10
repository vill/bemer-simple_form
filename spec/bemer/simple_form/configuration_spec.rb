# frozen_string_literal: true

RSpec.describe Bemer::SimpleForm::Configuration do
  subject(:configuration) { described_class.instance }

  describe '#bemify_namespaces' do
    it { expect(configuration.bemify_namespaces).to match_array %i[error hint input wrapper label] }
  end

  describe '#input_type_modifiers_for_namespaces' do
    it { expect(configuration.input_type_modifiers_for_namespaces).to match_array %i[input wrapper label] }
  end

  describe '#element_name_transformer' do
    it { expect(configuration.element_name_transformer).to be_nil }
  end
end
