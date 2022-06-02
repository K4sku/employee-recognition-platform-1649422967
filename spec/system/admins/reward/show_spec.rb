require 'rails_helper'

describe 'Reward show action', type: :system do
  before do
    sign_in admin
  end

  let(:admin) { create(:admin) }
  let!(:reward) { create(:reward) }

  context 'when admin is on reward show page' do
    it 'show reward title' do
      visit admins_reward_path(reward)
      expect(page).to have_content(reward.title)
      expect(page).to have_content(reward.description)
      expect(page).to have_content(reward.price)
    end

    it 'show Edit link' do
      visit admins_reward_path(reward)
      expect(page).to have_link('Edit')
    end

    it 'show Back link' do
      visit admins_reward_path(reward)
      expect(page).to have_link('Back')
    end
  end
end
