require 'rails_helper'

describe 'admins/employee.index', type: :system, js: true do
  before do
    create(:employee)
    create(:employee)
    sign_in admin
  end

  let(:employee) { create(:employee) }
  let(:admin) { create(:admin) }

  context 'when admin is logged' do
    it 'show all employess' do
      visit admins_employees_path
      expect(page).to have_selector(:css, "div[test_id^='employee_']", count: 2)
    end

    it 'shows delete links' do
      visit admins_employees_path
      expect(page).to have_link('Delete', count: 2)
    end

    it 'shows edit links' do
      visit admins_employees_path
      expect(page).to have_link('Edit', count: 2)
    end

    it 'shows show links' do
      visit admins_employees_path
      expect(page).to have_link('Show', count: 2)
    end
  end
end
