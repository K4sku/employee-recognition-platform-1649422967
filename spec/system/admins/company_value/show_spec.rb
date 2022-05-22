require 'rails_helper'

describe 'admins/Company_values.show', type: :system do
  before do
    driven_by(:rack_test)
    sign_in admin
  end

  let(:admin) { create(:admin) }
  let(:company_value) { create(:company_value) }

  context 'when admin is logged in' do
    context 'when on company_value show page'
    it 'show company_value title' do
      cvalue = create(:company_value)
      visit admins_company_value_path(cvalue)
      expect(page).to have_content(cvalue.title)
    end

    it 'show Edit link' do
      cvalue = create(:company_value)
      visit admins_company_value_path(cvalue)
      expect(page).to have_link('Edit')
    end

    it 'show Back link' do
      cvalue = create(:company_value)
      visit admins_company_value_path(cvalue)
      expect(page).to have_link('Back')
    end
  end
end
