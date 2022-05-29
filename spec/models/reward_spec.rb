require 'rails_helper'

RSpec.describe Reward, type: :model do
  # rubocop:disable RSpec/ImplicitExpect
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }

    # rubocop:disable RSpec/ImplicitSubject
    it do
      should validate_numericality_of(:price)
        .only_integer
        .is_greater_than_or_equal_to(1)
    end
    # rubocop:enable RSpec/ImplicitSubject
  end
  # rubocop:enable RSpec/ImplicitExpect
end
