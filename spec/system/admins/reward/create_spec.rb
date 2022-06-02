require 'rails_helper'

describe 'Reward create action', type: :system do
  before do
    sign_in admin
  end

  let(:admin) { create(:admin) }
  let!(:reward) { build(:reward) }

  context 'when admin is on index page' do
    it 'New Reward link' do
      visit admins_rewards_path
      click_on 'New Reward'
      expect(page).to have_current_path new_admins_reward_path
    end
  end

  context 'when creating valid reward' do
    it 'saves reward' do
      visit new_admins_reward_path
      fill_in 'Title', with: reward.title
      fill_in 'Description', with: reward.description
      fill_in 'Price', with: reward.price
      click_on 'Save Reward'
      expect(page).to have_current_path admins_rewards_path
      expect(page).to have_content(reward.title)
      expect(page).to have_content(reward.description)
      expect(page).to have_content(reward.price)
    end
  end

  context 'when failing validations' do
    it 'shows validation errors' do
      visit new_admins_reward_path
      click_on 'Save Reward'
      expect(page).to have_css("form[action='/admins/rewards']")
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("Price can't be blank")
    end
  end
end
