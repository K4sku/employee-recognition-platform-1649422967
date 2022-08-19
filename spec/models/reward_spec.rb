require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:categories) }

    # rubocop:disable RSpec/ImplicitSubject
    it do
      is_expected.to validate_numericality_of(:price)
        .only_integer
        .is_greater_than_or_equal_to(1)
    end
    # rubocop:enable RSpec/ImplicitSubject
  end
end
