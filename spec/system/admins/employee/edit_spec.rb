require 'rails_helper'

describe 'admins/emplyees.edit', type: :system, js: true do
  let(:employee) { create(:employee) }
  let(:admin) { create(:admin) }

  context 'when pressing edit link' do
    it 'shows edit employee form' do
      sign_in admin
      employee = create(:employee)
      visit admins_employees_path
      click_on 'Edit'
      expect(page).to have_current_path edit_admins_employee_path(employee)
      expect(page).to have_css "form[action='/admins/employees/#{employee.id}'][method='post']"
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
      expect(page).to have_field('Password confirmation')
      expect(page).to have_field('Number of available kudos')
    end
  end

  context 'when showing form' do
    it 'is prefilled with email and available kudos' do
      sign_in admin
      visit edit_admins_employee_path(employee)

      expect(page).to have_field('Email', with: employee.email)
      expect(page).to have_field('Password', with: '')
      expect(page).to have_field('Password confirmation', with: '')
      expect(page).to have_field('Number of available kudos', with: employee.number_of_available_kudos)
    end
  end

  context 'when editing emaployee' do
    context 'when passing validation' do
      it 'saves edited employee' do
        sign_in admin
        visit edit_admins_employee_path(employee)

        fill_in 'Email', with: 'newemail@test.com'
        fill_in 'Password', with: 'validpassword'
        fill_in 'Password confirmation', with: 'validpassword'
        fill_in 'Number of available kudos', with: 2
        click_on 'Save Employee'
        expect(page).to have_current_path admins_employees_path
        within "div[test_id='employee_#{employee.id}']" do
          expect(page).to have_content('newemail@test.com')
          expect(page).to have_content('Available kudos: 2')
        end
        expect(Employee.find(employee.id).valid_password?('validpassword')).to be true
      end
    end

    context 'when password fields are empty' do
      it 'does not change current password' do
        sign_in admin
        employee = create(:employee, password: 'oldpassword')
        visit edit_admins_employee_path(employee)

        fill_in 'Number of available kudos', with: 2
        click_on 'Save Employee'
        expect(page).to have_current_path admins_employees_path
        within "div[test_id='employee_#{employee.id}']" do
          expect(page).to have_content('Available kudos: 2')
        end
        expect(Employee.find(employee.id).valid_password?('oldpassword')).to be true
      end
    end

    context 'when missing email' do
      it 'render edit with error' do
        sign_in admin
        visit edit_admins_employee_path(employee)

        fill_in 'Email', with: ''
        click_on 'Save Employee'
        expect(page).to have_css "form[action='/admins/employees/#{employee.id}'][method='post']"
        expect(body).to have_content "Email can't be blank"
      end
    end

    context 'when password is too short' do
      it 'render edit with error' do
        sign_in admin
        visit edit_admins_employee_path(employee)

        fill_in 'Password', with: '123'
        fill_in 'Password confirmation', with: '123'
        click_on 'Save Employee'
        expect(page).to have_css "form[action='/admins/employees/#{employee.id}'][method='post']"
        expect(body).to have_content 'Password is too short (minimum is 6 characters)'
      end
    end

    context 'when password confirmation does not match' do
      it 'render edit with error' do
        sign_in admin
        visit edit_admins_employee_path(employee)

        fill_in 'Password', with: '123456789'
        fill_in 'Password confirmation', with: 'qbcdefgh'
        click_on 'Save Employee'
        expect(page).to have_css "form[action='/admins/employees/#{employee.id}'][method='post']"
        expect(body).to have_content "Password confirmation doesn't match Password"
      end
    end

    context 'when available kudos not matching' do
      it 'stay on page with HTML5 validation error' do
        sign_in admin
        visit edit_admins_employee_path(employee)

        expect do
          fill_in 'Number of available kudos', with: '-1'
          click_on 'Save Employee'
        end.not_to change { current_path }
        expect do
          fill_in 'Number of available kudos', with: '11'
          click_on 'Save Employee'
        end.not_to change { current_path }
        expect do
          fill_in 'Number of available kudos', with: '5.5'
          click_on 'Save Employee'
        end.not_to change { current_path }

        expect do
          fill_in 'Number of available kudos', with: 'seven'
          click_on 'Save Employee'
        end.not_to change { current_path }
      end
    end
  end
end
