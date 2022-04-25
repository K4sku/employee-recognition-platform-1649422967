require 'rails_helper'

describe 'Employee.available_kudos', type: :system, js: true do
  before do
    driven_by(:rack_test)
    create(:employee)
    create(:employee)
  end

  let(:employee) { create(:employee) }
  let(:kudo) { create(:kudo) }

  context 'when creating new kudo' do
    context 'when available_kudos more then 0' do
      it 'decrement available kudos' do
        login_as(employee, scope: :employee)
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
      login_as(no_kudo_employee, scope: :employee)
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
    it 'increments available kudos' do
      no_kudo_employee = create(:employee, number_of_available_kudos: 0)
      login_as(no_kudo_employee, scope: :employee)
      create(:kudo, giver: no_kudo_employee)
      visit kudos_path
      expect(page).to have_selector(:css, "div[id^='kudo_']", count: 1)
      expect(page).to have_content 'Available kudos: 0'
      click_on 'Delete'
      expect(page).to have_current_path kudos_path
      expect(page).to have_content 'Available kudos: 1'
      expect(page).to have_no_selector(:css, "div[id^='kudo_']")
    end
  end
end
