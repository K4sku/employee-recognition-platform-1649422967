require 'rails_helper'

describe 'When admin is on index page', type: :system do
  before do
    sign_in admin
    create_list(:kudo, 2, reciever: employee)
    create_list(:order, 2, employee: employee, purchase_price: reward.price)
  end

  let!(:admin) { create(:admin) }
  let!(:employee) { create(:employee) }
  let(:reward) { create(:reward) }
  let(:order) { build(:order) }

  it 'show all orders and Export to CSV button' do
    visit admins_orders_path
    expect(page).to have_selector(:css, "div[test_id^='order_']", count: 2)
    expect(page).to have_content('Reward_', count: 2)
    expect(page).to have_content(reward.description, count: 2)
    expect(page).to have_content("Price: #{reward.price}", count: 2)
    expect(page).to have_content(order.created_at.strftime('%F'), count: 2)
    expect(page).to have_link('Deliver', count: 2, exact: true)
    expect(page).to have_link('Export to CSV')
  end

  context 'when admin delivers order' do
    it 'marks delivered and sort by order_status' do
      visit admins_orders_path
      first_deliver_link = page.first(:link, text: 'Deliver')
      click_link 'Deliver', match: :first
      expect(first_deliver_link).not_to be(page.first(:link, text: 'Deliver'))
      expect(page).to have_link('Deliver', count: 1, exact: true)
      expect(page).to have_link('Delivered', count: 1, exact: true)
    end
  end
end
