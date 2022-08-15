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
      visit current_path
      expect(page).to have_selector(:css, "div[test_id='category_#{category.id}']")
      expect(page).to have_content 'Rewards with category: 0'
      accept_alert do
        click_on 'Delete'
      end
      expect(page).to have_current_path admins_categories_path
      expect(page).not_to have_selector(:css, "div[test_id='category_#{category.id}']")
    end
  end

  context 'when admin is destroying category with rewards' do
    it 'destroys category record' do
      category_with_rewards = create(:category_with_rewards)
      visit current_path
      expect(page).to have_selector(:css, "div[test_id='category_#{category_with_rewards.id}']")
      within(page.find(:css, "div[test_id='category_#{category_with_rewards.id}']")) do
        expect(page).to have_content 'Rewards with category: 2'
        accept_alert do
          click_on 'Delete'
        end
      end
      expect(page).to have_current_path admins_categories_path
      expect(page).to have_selector(:css, "div[test_id='category_#{category_with_rewards.id}']")
      expect(page).to have_content 'Categoty can not be deleted. There are rewards in this category.'
    end
  end
end
