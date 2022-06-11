require 'rails_helper'

describe 'Employee earned points', type: :system do
  let(:employee) { create(:employee) }

  context 'when emplyee is signed in' do
    it 'Navbar displays earned points for employee' do
      sign_in employee
      visit root_path
      expect(page).to have_content 'Points: 0'
      kudo = create(:kudo, reciever: employee)
      visit current_path
      expect(page).to have_content 'Points: 1'
      kudo.destroy
      visit current_path
      expect(page).to have_content 'Points: 0'
    end
  end
end
