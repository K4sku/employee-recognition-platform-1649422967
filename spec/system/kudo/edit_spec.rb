require 'rails_helper'

describe 'Kudo.edit', type: :system, js: true do
  include ActiveSupport::Testing::TimeHelpers
  before do
    create(:employee)
  end

  let(:employee) { create(:employee) }
  let(:kudo) { create(:kudo) }

  context 'when logged in' do
    context 'when pressing Edit Kudo link' do
      it 'shows Edit kudo form' do
        logged_employee = create(:employee)
        sign_in logged_employee
        owned_kudo = create(:kudo, giver: logged_employee)
        visit root_path
        click_link 'Edit'
        expect(page).to have_current_path edit_kudo_path(owned_kudo)
        expect(page).to have_css "form[action='/kudos/#{owned_kudo.id}'][method='post']"
      end
    end

    context 'when passing validation' do
      it 'edits kudo and shows kudo_path' do
        logged_employee = create(:employee)
        sign_in logged_employee
        owned_kudo = create(:kudo, giver: logged_employee)
        visit edit_kudo_path(owned_kudo)
        fill_in 'kudo_title', with: 'Lorem ipsum dolor sit amet'
        fill_in 'kudo_content', with: 'consectetur adipiscing elit. Sed dignissim dignissim urna vel ultrices.'
        last_option_reciever = page.find_field('Reciever').all('option').last.text
        page.select last_option_reciever, from: 'kudo_reciever_id'
        last_option_company_value = page.find_field('Company value').all('option').last.text
        page.select last_option_company_value, from: 'kudo_company_value_id'
        click_on 'Save Kudo'
        expect(page).to have_current_path kudo_path(owned_kudo)
        expect(page).to have_content 'Lorem ipsum dolor sit amet'
        expect(page).to have_content 'consectetur adipiscing elit. Sed dignissim dignissim urna vel ultrices.'
      end

      it 'fails after 5 minutes from kudo\'s creation' do
        logged_employee = create(:employee)
        sign_in logged_employee
        owned_kudo = create(:kudo, giver: logged_employee)
        visit root_path
        click_on 'Edit'
        fill_in 'kudo_title', with: 'Lorem ipsum dolor sit amet'
        fill_in 'kudo_content', with: 'consectetur adipiscing elit. Sed dignissim dignissim urna vel ultrices.'
        last_option_reciever = page.find_field('Reciever').all('option').last.text
        page.select last_option_reciever, from: 'kudo_reciever_id'
        last_option_company_value = page.find_field('Company value').all('option').last.text
        page.select last_option_company_value, from: 'kudo_company_value_id'
        travel 6.minutes
        click_on 'Save Kudo'
        expect(page).to have_current_path root_path
        expect(page).to have_content owned_kudo.title
        expect(page).to have_content 'You can not perform this action.'
      end
    end

    context 'when missing title' do
      it 'shows current form with entered data and displays error' do
        logged_employee = create(:employee)
        sign_in logged_employee
        owned_kudo = create(:kudo, giver: logged_employee)
        visit edit_kudo_path(owned_kudo)
        fill_in 'kudo_title', with: ''
        fill_in 'kudo_content', with: 'consectetur adipiscing elit.'
        click_on 'Save Kudo'
        expect(page).to have_css "form[action='/kudos/#{owned_kudo.id}'][method='post']"
        expect(page).to have_field 'kudo_content', with: 'consectetur adipiscing elit.'
        expect(page).to have_select 'kudo_reciever_id', selected: owned_kudo.reciever.email
        expect(page).to have_content "Title can't be blank"
      end
    end

    context 'when missing content' do
      it 'shows current form with entered data and displays error' do
        logged_employee = create(:employee)
        sign_in logged_employee
        owned_kudo = create(:kudo, giver: logged_employee)
        visit edit_kudo_path(owned_kudo)
        fill_in 'kudo_title', with: 'Lorem ipsum dolor sit amet'
        fill_in 'kudo_content', with: ''
        click_on 'Save Kudo'
        expect(page).to have_css "form[action='/kudos/#{owned_kudo.id}'][method='post']"
        expect(page).to have_field 'kudo_title', with: 'Lorem ipsum dolor sit amet'
        expect(page).to have_select 'kudo_reciever_id', selected: owned_kudo.reciever.email
        expect(page).to have_content "Content can't be blank"
      end
    end
  end
end
