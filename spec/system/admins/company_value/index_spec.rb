require 'rails_helper'

describe 'admins/Company_values.index', type: :system do
  before do
    driven_by(:rack_test)
    login_as(admin, { scope: :admin })
  end

  let(:admin) { create(:admin) }
  let(:company_value) { create(:company_value) }

  context 'when admin is logged in' do
    it 'show all company_values on index page' do
      create(:company_value)
      create(:company_value)
      visit admins_company_values_path
      expect(page).to have_selector(:css, "div[id^='company_value_']", count: 2)
    end

    it 'show delete link' do
      create(:company_value)
      visit admins_company_values_path
      expect(page).to have_link('Delete')
    end

    it 'show show link' do
      create(:company_value)
      visit admins_company_values_path
      expect(page).to have_link('Show')
    end

    it 'show edit link' do
      create(:company_value)
      visit admins_company_values_path
      expect(page).to have_link('Edit')
    end
  end
end
