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

    it 'validates image file type' do
      reward = create(:reward)
      reward.image = fixture_file_upload(Rails.root.join('spec/fixtures/files/valid_reward_image.jpg'), 'image/jpg')
      expect(reward).to be_valid
      reward.image = fixture_file_upload(Rails.root.join('spec/fixtures/files/valid_reward_image.png'), 'image/png')
      expect(reward).to be_valid
      reward.image = fixture_file_upload(Rails.root.join('spec/fixtures/files/invalid_reward_image.gif'), 'image/gif')
      expect(reward).to be_invalid
    end
  end
end
