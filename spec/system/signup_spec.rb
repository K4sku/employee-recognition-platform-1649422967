require 'rails_helper'

describe 'Employee', type: :system do
  before do
    driven_by(:rack_test)
    Capybara.match = :smart
    visit '/'
  end

  context 'when not signed in employee visit root_path' do
    it 'gets redirected to /employees/sign_in' do
      expect(page).to have_current_path('/employees/sign_in')
    end

    it 'shows link to sign up' do
      expect(page).to have_link 'Sign up'
    end

    context 'when clicked sign up link' do
      it 'leads sign up page' do
        click_link 'Sign up'
        expect(page).to have_current_path('/employees/sign_up')
      end

      context 'when on sign up page' do
        it 'takes email and password with password confirmation' do
          employee = build(:employee)
          click_link 'Sign up'
          fill_in 'employee_email', with: employee.email
          fill_in 'employee_password',	with: employee.password
          fill_in 'employee_password_confirmation',	with: employee.password
          click_button value: 'Sign up'
          expect(page).to have_content 'Welcome! You have signed up successfully.'
        end
      end
    end
  end
end
