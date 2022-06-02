require 'rails_helper'

describe 'Rewards displays all rewards in index', type: :system do
  before do
    sign_in admin
  end

  let(:admin) { create(:admin) }
  let(:reward) { create(:reward) }

  context 'when admin is on index page' do
    it 'show all rewards' do
      create_list(:reward, 3)
      visit admins_rewards_path
      expect(page).to have_selector(:css, "div[test_id^='reward_']", count: 3)
    end
  end

  it 'show New Reward link' do
    visit admins_rewards_path
    expect(page).to have_link('New Reward')
  end

  context 'when rewards exist' do
    it 'show Show, Edit, Delete link' do
      create(:reward)
      visit admins_rewards_path
      expect(page).to have_link('Show')
      expect(page).to have_link('Edit')
      expect(page).to have_link('Delete')
    end
  end
end
