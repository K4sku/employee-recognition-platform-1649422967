require 'rails_helper'

describe 'admin/pages/dashboard/Kudo.destroy' do
  before do
    driven_by(:rack_test)
    login_as(admin, scope: :admin)
    create(:kudo)
  end

  let(:admin) { create(:admin) }

  context 'when clicking on Destroy link while logged in as admin_user' do
    it 'remove kudo' do
      visit admins_pages_dashboard_path
      click_link 'Destroy'
      expect(page).to have_current_path admins_pages_dashboard_path
      expect(page).to have_no_selector(:css, "div[id^='kudo_']")
    end
  end
end
