require 'rails_helper'

describe 'the signup process', type: :system do
  before do
    employee = build(:employee)
  end

  it 'signs up a new employee' do
    visit '/'
    click_link 'Sign Up'
    fill_in 'employee_email', with: employee.email
    fill_in 'employee_password',	with: employee.password
    fill_in 'employee_password_confirmation',	with: employee.password
    click_on 'Sign Up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
