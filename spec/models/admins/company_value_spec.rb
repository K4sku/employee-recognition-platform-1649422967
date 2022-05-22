require 'rails_helper'

describe CompanyValue, type: :model do
  subject(:company_value) { described_class.new(title: title) }

  context 'when title is null' do
    let(:title) { '' }

    it { is_expected.not_to be_valid }
  end

  context 'when title is not null' do
    let(:title) { 'ExampleValue' }

    it { is_expected.to be_valid }
  end

  context 'when title is not unique' do
    let(:title) { 'Value' }

    it 'is not valid' do
      described_class.create(title: 'Value')
      expect(company_value).not_to be_valid
    end

    it 'is not valid case sensitive' do
      described_class.create(title: 'value')
      expect(company_value).not_to be_valid
    end
  end
end
