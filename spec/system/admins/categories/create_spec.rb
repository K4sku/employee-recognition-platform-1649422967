require 'rails_helper'

describe 'admins create Category', type: :system, js: true do
  let(:admin) { create(:admin) }
  let(:category) { build(:category) }

  before do
    sign_in admin
    visit admins_root_path
    page.find(:css, "div[test_id='admin_panel']").click
    within(:css, "div[test_id='admin_panel']") do
      click_on 'Categories'
    end
    click_on 'New Category'
  end

  context 'when admin is creating category' do
    it 'creates with title' do
      fill_in 'Title', with: category.title
      click_on 'Save'
      expect(page).to have_current_path admins_categories_path
      expect(page).to have_content(category.title)
    end

    it 'show error with blank title' do
      click_on 'Save'
      expect(page).to have_css("form[action='/admins/categories']")
      expect(page).to have_content("Title can't be blank")
    end

    it 'show error when title already exists (case sensitive)' do
      create(:category, title: 'Title1')
      fill_in 'Title', with: 'Title1'
      click_on 'Save'
      expect(page).to have_css("form[action='/admins/categories']")
      expect(page).to have_content('Title has already been taken')
    end

    it 'show error when title already exists (case insensitive)' do
      create(:category, title: 'Title1')
      fill_in 'Title', with: 'title1'
      click_on 'Save'
      expect(page).to have_css("form[action='/admins/categories']")
      expect(page).to have_content('Title has already been taken')
    end
  end
end
