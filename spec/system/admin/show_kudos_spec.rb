require 'rails_helper'

describe 'admin/pages#dashboard', type: :system, js: true do
  before do
    driven_by(:rack_test)
    login_as(admin_user, scope: :admin_user)
  end

  let(:admin_user) { create(:admin_user) }

  context 'when admin_user is logged' do
    it 'show all kudos' do
      create(:kudo)
      create(:kudo)
      create(:kudo)
      visit admin_pages_dashboard_path
      expect(page).to have_selector(:css, "div[id^='kudo_']", count: 3)
    end

    it 'show destroy links' do
      create(:kudo)
      visit admin_pages_dashboard_path

      expect(page).to have_content('Destroy')
      expect(page).to have_no_content('Show')
      expect(page).to have_no_content('Edit')
    end

    it 'do not show edit link' do
      create(:kudo)
      visit admin_pages_dashboard_path

      expect(page).to have_no_content('Edit')
    end

    it 'do not show show link' do
      create(:kudo)
      visit admin_pages_dashboard_path

      expect(page).to have_no_content('Show')
    end
  end
end
