require 'rails_helper'

describe 'admins/Company_values.edit', type: :system do
  before do
    driven_by(:rack_test)
    sign_in admin
  end

  let(:admin) { create(:admin) }

  context 'when admin is destroying company value' do
    it 'destroys company_value record' do
      create(:company_value)
      visit admins_company_values_path
      click_on 'Delete'
      expect(page).to have_current_path admins_company_values_path
      expect(page).not_to have_selector(:css, "div[id^='company_value_']")
    end
  end
end
