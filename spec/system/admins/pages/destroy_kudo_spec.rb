require 'rails_helper'

describe 'admin/pages/dashboard/Kudo.destroy', js: true do
  before do
    sign_in admin
    create(:kudo)
  end

  let(:admin) { create(:admin) }

  context 'when clicking on Destroy link while logged in as admin_user' do
    it 'remove kudo' do
      visit admins_kudos_path
      accept_alert do
        click_link 'Delete'
      end
      expect(page).to have_current_path admins_kudos_path
      expect(page).to have_no_selector(:css, "div[test_id^='kudo_']")
    end
  end
end
