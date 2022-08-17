require 'rails_helper'

describe 'admins destroy Category', type: :system, js: true do
  let(:admin) { create(:admin) }

  before do
    sign_in admin
    visit admins_root_path
    page.find(:css, "div[test_id='admin_panel']").click
    within(:css, "div[test_id='admin_panel']") do
      click_on 'Categories'
    end
  end

  context 'when admin is destroying category with no rewards' do
    it 'destroys category record' do
      category = create(:category)
      category_element = "div[test_id='category_#{category.id}']"
      visit current_path
      expect(page).to have_selector(:css, category_element)
      expect(page).to have_content 'Rewards with category: 0'
      accept_alert do
        click_on 'Delete'
      end
      expect(page).to have_current_path admins_categories_path
      expect(page).not_to have_selector(:css, category_element)
    end
  end

  context 'when admin is destroying category with rewards' do
    it 'prevents from destroing category' do
      category_with_rewards = create(:category_with_rewards)
      category_with_rewards_element = "div[test_id='category_#{category_with_rewards.id}']"
      visit current_path
      expect(page).to have_selector(:css, category_with_rewards_element)
      within(page.find(:css, category_with_rewards_element)) do
        expect(page).to have_content 'Rewards with category: 2'
        accept_alert do
          click_on 'Delete'
        end
      end
      expect(page).to have_current_path admins_categories_path
      expect(page).to have_selector(:css, category_with_rewards_element)
      expect(page).to have_content 'Categoty can not be deleted. There are rewards in this category.'
    end
  end
end
