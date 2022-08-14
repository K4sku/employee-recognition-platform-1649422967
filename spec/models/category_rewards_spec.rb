require 'rails_helper'

RSpec.describe CategoryReward, type: :model do
  it { is_expected.to validate_uniqueness_of(:category_id).scoped_to(:reward_id) }
end
