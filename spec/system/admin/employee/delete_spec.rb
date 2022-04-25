require 'rails_helper'

describe 'admins/employee.delete', type: :system, js: true do
  before do
    driven_by(:rack_test)
    create(:employee)
    create(:employee)
    login_as(admin, scope: :admin)
  end

  let(:employee) { create(:employee) }
  let(:admin) { create(:admin) }

  context 'when admin deletes' do
    it 'show all employess' do
      visit admins_employees_path
      expect(page).to have_selector(:css, "div[id^='employee_']", count: 2)
      click_on 'Delete', match: :first
      expect(page).to have_current_path admins_employees_path
      expect(page).to have_selector(:css, "div[id^='employee_']", count: 1)
    end
  end
end
