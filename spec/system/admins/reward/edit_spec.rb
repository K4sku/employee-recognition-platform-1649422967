require 'rails_helper'

describe 'Reward create action', type: :system, js: true do
  before do
    sign_in admin
  end

  let(:admin) { create(:admin) }
  let!(:reward) { create(:reward) }

  context 'when admin is on index page' do
    it 'Edit Reward link' do
      visit admins_rewards_path
      click_on 'Edit'
      expect(page).to have_current_path edit_admins_reward_path(reward)
    end
  end

  context 'when admin is on new reward page' do
    it 'displays reward form' do
      visit edit_admins_reward_path(reward)
      expect(page).to have_field('Title')
      expect(page).to have_field('Description')
      expect(page).to have_field('Price', type: 'number')
    end
  end

  context 'when creating valid reward' do
    it 'saves reward' do
      visit edit_admins_reward_path(reward)
      fill_in 'Title', with: 'Reward Title 1'
      fill_in 'Description', with: 'Lorem ipsum'
      fill_in 'Price', with: 10
      click_on 'Save Reward'
      expect(page).to have_current_path admins_reward_path(reward)
      expect(page).to have_content('Reward Title 1')
      expect(page).to have_content('Lorem ipsum')
      expect(page).to have_content('Price: 10')
    end
  end

  context 'when failing validations' do
    it 'shows validation errors' do
      visit edit_admins_reward_path(reward)
      fill_in 'Title', with: ''
      fill_in 'Description', with: ''
      fill_in 'Price', with: ''
      click_on 'Save Reward'
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("Price can't be blank")
    end
  end
end
