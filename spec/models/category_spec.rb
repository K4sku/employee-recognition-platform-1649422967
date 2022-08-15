require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of(:title) }

  describe 'validations' do
    subject { build(:category) }

    it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
  end
end
