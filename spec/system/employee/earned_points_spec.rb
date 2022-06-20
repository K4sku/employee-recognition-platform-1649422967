require 'rails_helper'

describe 'Employee earned points', type: :system, js: true do
  before do
    sign_in employee
  end

  let(:employee) { create(:employee) }
  let(:reward) { create(:reward, price: 3) }
  let(:expensive_reward) { create(:reward, price: 100) }
  let!(:kudo) { create(:kudo, reciever: employee) }

  context 'when emplyee is signed in' do
    it 'Navbar displays earned points for employee' do
      visit root_path
      expect(page).to have_content 'Points: 1'
      create(:kudo, reciever: employee)
      visit current_path
      expect(page).to have_content 'Points: 2'
    end

    it 'destorying kudo decreases points for employee' do
      # kudo = create(:kudo, reciever: employee)
      visit root_path
      expect(page).to have_content 'Points: 1'
      kudo.destroy
      visit current_path
      expect(page).to have_content 'Points: 0'
    end

    it 'placing order/claming reward decreases points for employee by reward price' do
      create_list(:kudo, 5, reciever: employee)
      visit reward_path(reward)
      expect(page).to have_content 'Points: 6'
      accept_confirm do
        click_on 'CLAIM REWARD!'
      end
      expect(page).to have_content 'Points: 3'
    end

    context 'when employee can not afford reward' do
      it 'shows warning toast' do
        visit reward_path(reward)
        accept_confirm do
          click_on 'CLAIM REWARD!'
        end
        expect(page).to have_content 'You can not afford this reward'
      end
    end
  end
end
