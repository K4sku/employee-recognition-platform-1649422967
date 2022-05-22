require 'rails_helper'

describe 'Employee.sign_out', type: :system do
  let(:admin) { create(:admin) }

  context 'when signed in' do
    it 'shows sign out link' do
      sign_in admin
      visit admins_pages_dashboard_path
      expect(page).to have_link 'Sign out'
    end

    describe 'when click on sign out' do
      it 'signs out admin' do
        sign_in admin
        visit admins_pages_dashboard_path
        click_link 'Sign out'
        expect(page).to have_button 'Log in'
      end
    end
  end
end
