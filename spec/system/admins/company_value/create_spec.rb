require 'rails_helper'

describe 'admins/Company_values.create', type: :system, js: true do
  before do
    sign_in admin
  end

  let(:admin) { create(:admin) }
  let(:company_value) { build(:company_value) }

  context 'when admin is creating company value' do
    it 'creates with title' do
      visit new_admins_company_value_path
      fill_in 'Title', with: company_value.title
      click_on 'Save'
      expect(page).to have_current_path admins_company_values_path
      expect(page).to have_content(company_value.title)
    end

    it 'return error with blank title' do
      visit new_admins_company_value_path
      click_on 'Save'
      expect(page).to have_css("form[action='/admins/company_values']")
      expect(page).to have_content("Title can't be blank")
    end

    it 'return error when title already exists (case sensitive)' do
      create(:company_value, title: 'Title1')
      visit new_admins_company_value_path
      fill_in 'Title', with: 'Title1'
      click_on 'Save'
      expect(page).to have_css("form[action='/admins/company_values']")
      expect(page).to have_content('Title has already been taken')
    end

    it 'return error when title already exists (case insensitive)' do
      create(:company_value, title: 'Title1')
      visit new_admins_company_value_path
      fill_in 'Title', with: 'title1'
      click_on 'Save'
      expect(page).to have_css("form[action='/admins/company_values']")
      expect(page).to have_content('Title has already been taken')
    end
  end
end
