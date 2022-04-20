require 'rails_helper'

describe 'Employee.sign_in', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:employee) { create(:employee) }

  context 'when not signed in' do
    it 'gets redirected to new_employee_session_path' do
      visit '/'
      expect(page).to have_current_path new_employee_session_path
    end

    it "don't show link to sign out" do
      visit '/'
      expect(page).to have_no_link 'Sign out'
    end
  end

  context 'when signing in' do
    context 'with valid credentials' do
      it do
        visit new_employee_session_path
        fill_in 'employee_email', with: employee.email
        fill_in 'employee_password',	with: employee.password
        click_button value: 'Log in'
        expect(page).to have_text 'Signed in successfully.'
      end
    end

    context 'with invalid credentials' do
      it do
        visit new_employee_session_path
        fill_in 'employee_email', with: 'invalid@email.address'
        fill_in 'employee_password',	with: '111'
        click_button value: 'Log in'
        expect(page).to have_text 'Invalid Email or password.'
      end
    end
  end
end
