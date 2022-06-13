require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:employee) { create(:employee) }
  let(:expensive_reward) { create(:reward, price: 100) }

  # rubocop:disable RSpec/ImplicitExpect
  describe 'validations' do
    it { should belong_to(:employee) }
    it { should belong_to(:reward) }

    it 'is expected check that employee can afford reward' do
      order = described_class.new(employee: employee, reward: expensive_reward)
      expect(order).to be_invalid
      expect(order.errors).to include('can_not_afford')
    end
  end
  # rubocop:enable RSpec/ImplicitExpect
end
