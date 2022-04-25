require 'rails_helper'

describe 'admins/employee.index', type: :system, js: true do
  before do
    driven_by(:rack_test)
    create(:employee)
    create(:employee)
    login_as(admin, scope: :admin)
  end

  let(:employee) { create(:employee) }
  let(:admin) { create(:admin) }

  context 'when admin is logged' do
    it 'show all employess' do
      visit admins_employees_path
      expect(page).to have_selector(:css, "div[id^='employee_']", count: 2)
    end

    it 'shows delete links' do
      visit admins_employees_path
      expect(page).to have_link('Delete', count: 2)
    end

    it 'shows edit links' do
      visit admins_employees_path
      expect(page).to have_link('Edit', count: 2)
    end
  end
end