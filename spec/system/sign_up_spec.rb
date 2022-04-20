require 'rails_helper'

describe 'Employee.registration', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:employee) { build(:employee) }

  context 'when not signed in' do
    it 'shows sign up link' do
      visit root_path
      expect(page).to have_link 'Sign up'
    end

    context 'when clicked sign up link' do
      it 'shows sign up page' do
        Capybara.match = :first
        visit root_path
        click_link 'Sign up'
        expect(page).to have_current_path new_employee_registration_path
      end
    end
  end

  context 'when signing up' do
    context 'with valid credentials' do
      it 'create account' do
        visit new_employee_registration_path
        fill_in 'employee_email', with: employee.email
        fill_in 'employee_password',	with: employee.password
        fill_in 'employee_password_confirmation',	with: employee.password
        click_button value: 'Sign up'
        expect(page).to have_text 'Welcome! You have signed up successfully.'
      end
    end

    context 'with existing credentials' do
      it 'returns error' do
        employee.save
        visit new_employee_registration_path
        fill_in 'employee_email', with: employee.email
        fill_in 'employee_password',	with: employee.password
        fill_in 'employee_password_confirmation',	with: employee.password
        click_button value: 'Sign up'
        expect(page).to have_text 'Email has already been taken'
      end
    end

    context 'without email' do
      it 'returns error' do
        visit new_employee_registration_path
        fill_in 'employee_password',	with: employee.password
        fill_in 'employee_password_confirmation',	with: employee.password
        click_button value: 'Sign up'
        expect(body).to have_text "Email can't be blank"
      end
    end

    context 'with invalid email' do
      it 'returns error' do
        visit new_employee_registration_path
        fill_in 'employee_email', with: 'invalid_email'
        fill_in 'employee_password',	with: employee.password
        fill_in 'employee_password_confirmation',	with: employee.password
        click_button value: 'Sign up'
        expect(page).to have_no_text 'Please enter an email address.'
      end
    end

    context 'without password' do
      it 'returns error' do
        visit new_employee_registration_path
        fill_in 'employee_email', with: employee.email
        click_button value: 'Sign up'
        expect(body).to have_text "Password can't be blank"
      end
    end

    context 'with invalid password' do
      it 'returns error' do
        visit new_employee_registration_path
        fill_in 'employee_email', with: employee.email
        fill_in 'employee_password',	with: 'short'
        fill_in 'employee_password_confirmation',	with: 'short'
        click_button value: 'Sign up'
        expect(body).to have_text 'Password is too short (minimum is 6 characters)'
      end
    end

    context 'with invalid password confirmation' do
      it 'returns error' do
        visit new_employee_registration_path
        fill_in 'employee_email', with: employee.email
        fill_in 'employee_password',	with: employee.password
        fill_in 'employee_password_confirmation',	with: 'short'
        click_button value: 'Sign up'
        expect(body).to have_text "Password confirmation doesn't match Password"
      end
    end
  end
end
