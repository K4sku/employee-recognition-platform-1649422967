require 'rails_helper'

describe 'Reward create action', type: :system, js: true do
  let(:admin) { create(:admin) }
  let!(:reward) { build(:reward) }
  let!(:category1) { create(:category) }
  let!(:category2) { create(:category) }

  before do
    sign_in admin
  end

  context 'when admin is on index page' do
    it 'New Reward link' do
      visit admins_rewards_path
      click_on 'New Reward'
      expect(page).to have_current_path new_admins_reward_path
    end
  end

  context 'when creating reward' do
    before do
      visit admins_root_path
      page.find(:css, "div[test_id='admin_panel']").click
      within(:css, "div[test_id='admin_panel']") do
        click_on 'Rewards'
      end
      click_on 'New Reward'
    end

    it 'saves valid reward' do
      fill_in 'Title', with: reward.title
      fill_in 'Description', with: reward.description
      fill_in 'Price', with: reward.price
      page.find(:css, "input[test_id='category_input']").click
      page.find(:link, category1.title).click
      page.find(:css, "input[test_id='category_input']").click
      page.find(:link, category2.title).click
      click_on 'Save Reward'
      expect(page).to have_current_path admins_rewards_path
      expect(page).to have_content(reward.title)
      expect(page).to have_content(reward.description)
      expect(page).to have_content(reward.price)
      expect(page).to have_content(category1.title)
      expect(page).to have_content(category2.title)
    end

    context 'when failing validations' do
      it 'shows validation errors' do
        page.find(:button, 'Save Reward').click
        expect(page).to have_css("form[action='/admins/rewards']")
        expect(page).to have_content("Title can't be blank")
        expect(page).to have_content("Description can't be blank")
        expect(page).to have_content("Price can't be blank")
      end
    end
  end
end
