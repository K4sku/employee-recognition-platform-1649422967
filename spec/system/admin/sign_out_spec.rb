require 'rails_helper'

describe 'Employee.sign_out', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:admin) { create(:admin) }

  context 'when signed in' do
    it 'shows sign out link' do
      login_as(admin, scope: :admin)
      visit admins_pages_dashboard_path
      expect(page).to have_link 'Sign out'
    end

    describe 'when click on sign out' do
      it do
        login_as(admin, scope: :admin)
        visit admins_pages_dashboard_path
        click_link 'Sign out'
        expect(page).to have_button 'Log in'
      end
    end
  end
end
