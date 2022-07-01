require 'rails_helper'

describe 'Employee can list bought rewards', type: :system do
  before do
    sign_in employee
    sign_in admin
    create_list(:kudo, 3, reciever: employee)
    create_list(:order, 2, employee: employee, purchase_price: reward.price)
  end

  let!(:admin) { create(:admin) }
  let!(:employee) { create(:employee) }
  let(:reward) { create(:reward) }
  let(:expensive_reward) { create(:reward, price: 10) }

  context 'when employee goes to order list' do
    it 'show all employees orders' do
      visit orders_path
      expect(page).to have_selector(:css, "div[test_id^='order_']", count: 2)
      expect(page).to have_content(reward.title, count: 2)
      expect(page).to have_content(reward.description, count: 2)
      expect(page).to have_content("Price: #{reward.price}", count: 2)
      expect(page).to have_content(reward.created_at.strftime('%F'), count: 2)
    end
  end

  context 'when admin edits price list' do
    it 'does not change displayed price' do
      visit edit_admins_reward_path(reward)
      old_price = reward.price
      fill_in 'Price', with: 10
      click_on 'Save Reward'
      expect(page).to have_content('Price: 10')
      visit orders_path
      expect(page).to have_selector(:css, "div[test_id^='order_']", count: 2)
      expect(page).to have_content("Price: #{old_price}", count: 2)
    end
  end
end
