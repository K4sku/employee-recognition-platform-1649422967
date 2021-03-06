require 'rails_helper'

describe 'Employee.sign_out', type: :system do
  let(:employee) { create(:employee) }

  context 'when signed in' do
    it 'shows sign out link' do
      sign_in employee
      visit '/'
      expect(page).to have_link 'Sign out'
    end

    describe 'when click on sign out' do
      it do
        sign_in employee
        visit '/'
        click_link 'Sign out'
        expect(page).to have_link 'Sign in'
      end
    end
  end
end
