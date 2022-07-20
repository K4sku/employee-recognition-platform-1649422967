require 'rails_helper'

describe 'Employee can list bought rewards', type: :system, js: true do
  before do
    sign_in employee
    sign_in admin
    create_list(:kudo, 3, reciever: employee)
    create_list(:order, 2, employee: employee, purchase_price: reward.price)
    create_list(:order, 1, employee: employee, purchase_price: reward.price, status: :delivered)
  end

  let!(:admin) { create(:admin) }
  let!(:employee) { create(:employee) }
  let(:reward) { create(:reward) }
  let(:expensive_reward) { create(:reward, price: 10) }

  context 'when employee goes to order list' do
    it 'show all employees orders and highlights all' do
      visit orders_path
      expect(page).to have_selector(:css, "div[test_id^='order_']", count: 3)
      expect(page).to have_content(reward.title, count: 3)
      expect(page).to have_content(reward.description, count: 3)
      expect(page).to have_content("Price: #{reward.price}", count: 3)
      expect(page).to have_content(reward.created_at.strftime('%F'), count: 3)
      expect(page).to have_content('Status: delivered', count: 1)
      expect(page).to have_content('Status: placed', count: 2)
      expect(page.find_link('all').ancestor('li')[:class]).to eq('is-active')
    end

    context 'when employee clicks on filters' do
      it 'show only filtered orders' do
        visit orders_path
        click_on 'delivered'
        expect(page).to have_selector(:css, "div[test_id^='order_']", count: 1)
        expect(page).to have_content('Status: delivered', count: 1)
        expect(page.find_link('delivered').ancestor('li')[:class]).to eq('is-active')

        click_on 'not delivered'
        expect(page).to have_selector(:css, "div[test_id^='order_']", count: 2)
        expect(page).to have_content('Status: placed', count: 2)
        expect(page.find_link('not delivered').ancestor('li')[:class]).to eq('is-active')

        click_on 'all'
        expect(page).to have_selector(:css, "div[test_id^='order_']", count: 3)
        expect(page.find_link('all').ancestor('li')[:class]).to eq('is-active')
      end
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
      expect(page).to have_selector(:css, "div[test_id^='order_']", count: 3)
      expect(page).to have_content("Price: #{old_price}", count: 3)
    end
  end
end
