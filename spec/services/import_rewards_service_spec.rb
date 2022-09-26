require 'rails_helper'

describe ImportRewardsService, type: :model do
  describe '#call' do
    it 'imports records from valid files' do
      create(:category, title: 'junk')
      source = Rails.root.join('spec/fixtures/files/rewards.csv')
      headers = true
      expect { described_class.new(source, headers).call }.to change { Reward.all.count }.by(1)
    end

    it 'rollbacks transaction and shows errors when fails' do
      create(:category, title: 'junk')
      source = Rails.root.join('spec/fixtures/files/invalid_quoting_rewards.csv')
      headers = nil
      service = described_class.new(source, headers)
      expect { service.call }.not_to change { Reward.all.count }
      expect(service.errors).to include('Illegal quoting in line 2.')

      source = Rails.root.join('spec/fixtures/files/duplicated_titles_rewards.csv')
      service = described_class.new(source, headers)
      expect { service.call }.not_to change { Reward.all.count }
      expect(service.errors).to include("Duplicated entry with title 'second Reward'. Rewards names must be unique.")

      source = Rails.root.join('spec/fixtures/files/missing_values_rewards.csv')
      service = described_class.new(source, headers)
      expect { service.call }.not_to change { Reward.all.count }
      expect(service.errors).to include("Error for 'second Reward': Description can't be blank")
    end
  end
end
