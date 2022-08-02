require 'rails_helper'

describe 'Admin add avaible kudos to employees', type: :system do
  let(:employee) { create(:employee) }
  let(:admin) { create(:admin) }

  context 'when visiting add_kudos_path' do
    it 'shows form' do
      sign_in admin
      visit add_kudos_admins_employees_path
      expect(page).to have_css "form[action='/admins/employees/add_kudos'][method='post']"
      expect(page).to have_field('number_of_available_kudos_to_add', type: 'number')
      expect(page).to have_button('Add kudos')
    end
  end
end
