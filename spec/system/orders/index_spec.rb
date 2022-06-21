require 'rails_helper'

describe 'Employee can list bought rewards', type: :system do
  let!(:employee) { create(:employee) }
  let!(:kudo) { create(:kudo, reciever: employee) }
  let(:expensive_reward) { create(:reward, price: 10) }

  context 'when employee goes to order list' do
    it 'show all employees orders' do
      sign_in employee
      visit orders_path
      # puts page.body
      order = create(:order, employee: employee)
      puts order.inspect
      order.save
      expect(page).to have_selector(:css, "div[test_id^='order_']", count: 1)
    end
  end
end
