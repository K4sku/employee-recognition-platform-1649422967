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

  context 'when input is corect' do
    it 'increase avaible kudos and go to employee index' do
      sign_in admin
      visit add_kudos_admins_employees_path
      fill_in 'Number of available kudos to add', with: '2'
      expect do
        click_on 'Add kudos'
        employee.reload
      end
        .to change(employee, :number_of_available_kudos)
        .by(2)
        .and change { current_path }.to(admins_employees_path)
    end
  end

  context 'when input is incorrect' do
    it 'shows do not increase avaible kudos and stay on page' do
      sign_in admin
      visit add_kudos_admins_employees_path
      fill_in 'Number of available kudos to add', with: '30'
      expect { click_on 'Add kudos' }
        .not_to change(employee, :number_of_available_kudos)
      expect { click_on 'Add kudos' }
        .not_to change { current_path }
    end
  end
end
