require 'rails_helper'

describe 'Admin can see dedicated navbar panel', type: :system do
  let!(:admin) { create(:admin) }
  let(:order) { build(:order) }

  context 'when admin is not logged in' do
    it 'does not show admin panel in navbar' do
      visit admins_root_path
      expect(page).not_to have_selector(:css, "div[test_id='admin_panel']")
    end
  end

  context 'when admin is logged in' do
    before { sign_in admin }

    it 'show admin panel in navbar' do
      visit admins_root_path
      expect(page).to have_selector(:css, "div[test_id='admin_panel']")
    end

    it 'shows links in panel dropdown' do
      visit admins_root_path
      admin_panel = page.find("div[test_id='admin_panel']").find('.navbar-dropdown')
      expect(admin_panel).to have_link('Dashboard')
      expect(admin_panel).to have_link('Kudos')
      expect(admin_panel).to have_link('Add Kudos')
      expect(admin_panel).to have_link('Employees')
      expect(admin_panel).to have_link('Company Values')
      expect(admin_panel).to have_link('Rewards')
      expect(admin_panel).to have_link('Categories')
      expect(admin_panel).to have_link('Orders')
      expect(admin_panel).to have_link('Sign out Admin')
    end

    context 'when admin delivers order' do
      it 'decreases undelivered orders count in navbar' do
        create_list(:order, 2, :skip_validate)
        visit admins_orders_path
        expect { click_link 'Deliver', match: :first }
          .to change { page.find_link('undelivered_orders_count').text }
          .from('Orders ( 2 )')
          .to('Orders ( 1 )')
      end
    end
  end
end
