require 'rails_helper'

describe 'Admin can deliver placed orders', type: :system do
  before do
    sign_in admin
    create_list(:kudo, 2, reciever: employee)
    create_list(:order, 2, employee: employee, purchase_price: reward.price)
  end

  let!(:admin) { create(:admin) }
  let!(:employee) { create(:employee) }
  let(:reward) { create(:reward) }
  let(:order) { create(:order) }

  context 'when admin goes to orders list' do
    it 'show all orders' do
      visit admins_orders_path
      expect(page).to have_selector('a', text: 'Orders ( 2 )', visible: :all)
      expect(page).to have_selector(:css, "div[test_id^='order_']", count: 2)
      expect(page).to have_content(reward.title, count: 2)
      expect(page).to have_content(reward.description, count: 2)
      expect(page).to have_content("Price: #{reward.price}", count: 2)
      expect(page).to have_content(reward.created_at.strftime('%F'), count: 2)
      expect(page).to have_link('Deliver', count: 2, exact: true)
    end
  end

  context 'when admin delivers order' do
    it 'decreases undelivered orders count, marks and sort delivered' do
      visit admins_orders_path
      first_deliver_link = page.first(:link, text: 'Deliver')
      click_link 'Deliver', match: :first
      expect(first_deliver_link).not_to be(page.first(:link, text: 'Deliver'))
      expect(page).to have_selector('a', text: 'Orders ( 1 )', visible: :all)
      expect(page).to have_link('Deliver', count: 1, exact: true)
      expect(page).to have_link('Delivered', count: 1, exact: true)
    end
  end
end
