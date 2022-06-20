require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:employee) { create(:employee) }
  let(:expensive_reward) { create(:reward, price: 100) }

  # rubocop:disable RSpec/ImplicitExpect
  describe 'validations' do
    it { should belong_to(:employee) }
    it { should belong_to(:reward) }
  end
  # rubocop:enable RSpec/ImplicitExpect
end
