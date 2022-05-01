require 'rails_helper'

describe 'AdminUser.sign_in', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:admin) { create(:admin) }

  context 'when not signed in when wisiting webpage/admin' do
    it 'gets redirected to new_employee_session_path' do
      visit '/admins'
      expect(page).to have_current_path new_admin_session_path
    end

    it "don't show link to sign out" do
      visit '/admins'
      expect(page).to have_no_link 'Sign out'
    end
  end

  context 'when signing in' do
    context 'with valid credentials' do
      it do
        visit new_admin_session_path
        fill_in 'admin_email', with: admin.email
        fill_in 'admin_password',	with: admin.password
        click_button value: 'Log in'
        expect(page).to have_current_path admins_pages_dashboard_path
        expect(page).to have_content admin.email
      end
    end

    context 'with invalid credentials' do
      it do
        visit new_admin_session_path
        fill_in 'admin_email', with: 'invalid@email.address'
        fill_in 'admin_password',	with: '111'
        click_button value: 'Log in'
        expect(page).to have_current_path new_admin_session_path
      end
    end
  end
end
