require 'rails_helper'

describe 'Employee.available_kudos', type: :system, js: true do
  before do
    create(:employee)
    create(:employee)
  end

  let(:employee) { create(:employee) }
  let(:kudo) { create(:kudo) }

  context 'when creating new kudo' do
    context 'when available_kudos more then 0' do
      it 'decrement available kudos' do
        sign_in employee
        visit new_kudo_path
        expect(page).to have_content 'Available kudos: 10'
        fill_in 'kudo_title', with: 'Lorem ipsum dolor sit amet'
        fill_in 'kudo_content', with: 'consectetur adipiscing elit. Sed dignissim dignissim urna vel ultrices.'
        last_option = page.all('option').last.text
        page.select last_option, from: 'kudo_reciever_id'
        click_on 'Save Kudo'
        expect(page).to have_current_path kudos_path
        expect(page).to have_content 'Lorem ipsum dolor sit amet'
        expect(page).to have_content 'Available kudos: 9'
      end
    end
  end

  context 'when available_kudos is 0' do
    it "don't create kudo" do
      no_kudo_employee = create(:employee, number_of_available_kudos: 0)
      sign_in no_kudo_employee
      visit new_kudo_path
      expect(page).to have_content 'Available kudos: 0'
      fill_in 'kudo_title', with: 'Lorem ipsum dolor sit amet'
      fill_in 'kudo_content', with: 'consectetur adipiscing elit. Sed dignissim dignissim urna vel ultrices.'
      last_option = page.all('option').last.text
      page.select last_option, from: 'kudo_reciever_id'
      click_on 'Save Kudo'
      expect(page).to have_current_path kudos_path
      expect(page).to have_no_content 'Lorem ipsum dolor sit amet'
      expect(page).to have_content 'Available kudos: 0'
    end
  end

  context 'when deleting kudo' do
    it 'does not increments available kudos' do
      no_kudo_employee = create(:employee, number_of_available_kudos: 0)
      sign_in no_kudo_employee
      create(:kudo, giver: no_kudo_employee)
      visit kudos_path
      expect(page).to have_selector(:css, "div[test_id^='kudo_']", count: 1)
      expect(page).to have_content 'Available kudos: 0'
      accept_alert do
        click_on 'Delete'
      end
      expect(page).to have_current_path kudos_path
      expect(page).to have_content 'Kudo was successfully destroyed.'
      expect(page).to have_selector(:css, "div[test_id^='kudo_']", count: 0)
      expect(page).to have_content 'Available kudos: 0'
    end
  end
end
