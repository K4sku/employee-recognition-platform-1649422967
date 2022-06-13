require 'rails_helper'

describe 'Employee earned points', type: :system do
  let(:employee) { create(:employee) }
  let(:reward) { create(:reward, price: 3) }

  context 'when emplyee is signed in' do
    it 'Navbar displays earned points for employee' do
      sign_in employee
      visit root_path
      expect(page).to have_content 'Points: 0'
      create(:kudo, reciever: employee)
      visit current_path
      expect(page).to have_content 'Points: 1'
    end

    it 'destorying kudo decreases points for employee' do
      sign_in employee
      kudo = create(:kudo, reciever: employee)
      visit root_path
      expect(page).to have_content 'Points: 1'
      kudo.destroy
      visit current_path
      expect(page).to have_content 'Points: 0'
    end

    it 'placing order/claming reward decreases points for employee by reward price' do
      sign_in employee
      create_list(:kudo, 5, reciever: employee)
      visit reward_path(reward)
      expect(page).to have_content 'Points: 5'
      click_on 'CLAIM REWARD!'
      expect(page).to have_content 'Points: 2'
    end
  end
end
