require 'rails_helper'

describe 'admins/Company_values.edit', type: :system, js: true do
  before do
    sign_in admin
  end

  let(:admin) { create(:admin) }
  let(:company_value) { create(:company_value) }

  context 'when admin is editing company value' do
    it 'edits with title' do
      visit edit_admins_company_value_path(company_value)
      fill_in 'Title', with: 'other title'
      click_on 'Save'
      expect(page).to have_current_path admins_company_value_path(company_value)
      expect(page).to have_content('other title')
    end

    it 'return error with blank title' do
      visit edit_admins_company_value_path(company_value)
      fill_in 'Title', with: ''
      click_on 'Save'
      expect(page).to have_css("form[action='/admins/company_values/#{company_value.id}']")
      expect(page).to have_content("Title can't be blank")
    end

    it 'return error when title already exists (case sensitive)' do
      create(:company_value, title: 'Title1')
      visit edit_admins_company_value_path(company_value)
      fill_in 'Title', with: 'Title1'
      click_on 'Save'
      expect(page).to have_css("form[action='/admins/company_values/#{company_value.id}']")
      expect(page).to have_content('Title has already been taken')
    end

    it 'return error when title already exists (case insensitive)' do
      create(:company_value, title: 'Title1')
      visit edit_admins_company_value_path(company_value)
      fill_in 'Title', with: 'title1'
      click_on 'Save'
      expect(page).to have_css("form[action='/admins/company_values/#{company_value.id}']")
      expect(page).to have_content('Title has already been taken')
    end
  end
end
