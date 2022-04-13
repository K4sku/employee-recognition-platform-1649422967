require 'rails_helper'

describe 'Employee', type: :system do
  before do
    driven_by(:selenium)
  end

  let(:employee) { build(:employee) }

  context 'when not signed in' do
    it 'gets redirected to /employees/sign_in' do
      visit '/'
      expect(page).to have_current_path('/employees/sign_in')
    end

    it 'shows link to sign up' do
      visit '/'
      expect(page).to has_link?('Sign up')
    end

    it "don't show link to sign out" do
      visit '/'
      expect(page).to have_no_link('Sign out')
    end

    context 'when clicked sign up link' do
      it 'leads sign up page' do
        visit '/'
        click_link 'Sign up'
        expect(page).to have_current_path(new_employee_registration_path)
      end
    end

    context 'when on sign up page' do
      it 'can sign up with email and password' do
        visit new_employee_registration_path
        fill_in 'employee_email', with: employee.email
        fill_in 'employee_password',	with: employee.password
        fill_in 'employee_password_confirmation',	with: employee.password
        click_button value: 'Sign up'
        expect(page).to has_text?('Welcome! You have signed up successfully.')
      end

      it 'can not sign up with invalid email' do
        visit '/employees/sign_up'
        fill_in 'employee_email', with: 'invalid_email'
        fill_in 'employee_password',	with: employee.password
        fill_in 'employee_password_confirmation',	with: employee.password
        click_button value: 'Sign up'
        puts page
        expect(page).to has_no_text?('Please enter an email address.')
      end
    end
  end
end
