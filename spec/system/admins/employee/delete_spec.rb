require 'rails_helper'

describe 'admins/employee.delete', type: :system, js: true do
  before do
    driven_by(:rack_test)
    login_as(admin, scope: :admin)
  end

  let(:employee) { create(:employee) }
  let(:admin) { create(:admin) }

  context 'when admin deletes' do
    it 'removes employee' do
      create(:employee)
      create(:employee)
      visit admins_employees_path
      expect(page).to have_selector(:css, "div[id^='employee_']", count: 2)
      click_on 'Delete', match: :first
      expect(page).to have_current_path admins_employees_path
      expect(page).to have_selector(:css, "div[id^='employee_']", count: 1)
    end

    it 'removes kudos given by deleted employee' do
      employee1 = create(:employee)
      create(:kudo, giver: employee1)
      visit admins_employees_path
      expect(page).to have_selector(:css, "div[id^='employee_']", count: 2)
      click_on 'Delete', match: :first
      expect(page).to have_current_path admins_employees_path
      expect(page).to have_selector(:css, "div[id^='employee_']", count: 1)
      visit admins_pages_dashboard_path
      expect(page).to have_selector(:css, "div[id^='kudo_']", count: 0)
    end

    it 'removes kudos recieved by deleted employee' do
      employee1 = create(:employee)
      create(:kudo, reciever: employee1)
      visit admins_employees_path
      expect(page).to have_selector(:css, "div[id^='employee_']", count: 2)
      click_on 'Delete', match: :first
      expect(page).to have_current_path admins_employees_path
      expect(page).to have_selector(:css, "div[id^='employee_']", count: 1)
      visit admins_pages_dashboard_path
      expect(page).to have_selector(:css, "div[id^='kudo_']", count: 0)
    end
  end
end
