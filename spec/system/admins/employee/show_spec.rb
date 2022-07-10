require 'rails_helper'

describe 'admins see employees rewards', type: :system, js: true do
  before do
    create(:employee)
    create(:kudo, reciever: employee)
    sign_in admin
  end

  let(:employee) { create(:employee) }
  let(:admin) { create(:admin) }
  let(:reward) { create(:reward) }
  let!(:order) { create(:order, employee: employee, purchase_price: reward.price) }

  context 'when admin visits employee show page' do
    it 'shows employees email, avaible kudos and bought rewards' do
      visit admins_employee_path(employee)
      expect(page).to have_content employee.email
      expect(page).to have_content employee.number_of_available_kudos
      expect(page).to have_content employee.points
      expect(page).to have_content(order.reward.title)
      expect(page).to have_content(order.reward.description)
      expect(page).to have_content("Price: #{order.purchase_price}")
      expect(page).to have_content(order.reward.created_at.strftime('%F'))
    end
  end
end
