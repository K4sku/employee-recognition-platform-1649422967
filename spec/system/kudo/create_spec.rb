require 'rails_helper'

describe 'Kudo.create', type: :system, js: true do
  before do
    create_list(:employee, 2)
    create :company_value
    sign_in employee
  end

  let(:employee) { create(:employee) }
  let(:kudo) { create(:kudo) }

  context 'when logged in' do
    context 'when pressing New Kudo link' do
      it 'shows new kudo form' do
        visit root_path
        click_link 'New Kudo'
        expect(page).to have_current_path new_kudo_path
        expect(page).to have_css "form[action='/kudos'][method='post']"
      end
    end

    context 'when passing validation' do
      it 'saves kudo and shows kudos_path' do
        visit new_kudo_path
        fill_in 'kudo_title', with: 'Lorem ipsum dolor sit amet'
        fill_in 'kudo_content', with: 'consectetur adipiscing elit. Sed dignissim dignissim urna vel ultrices.'
        last_option_reciever = page.find_field('Reciever').all('option').last.text
        page.select last_option_reciever, from: 'kudo_reciever_id'
        last_option_company_value = page.find_field('Company value').all('option').last.text
        page.select last_option_company_value, from: 'kudo_company_value_id'
        click_on 'Save Kudo'
        expect(page).to have_current_path kudos_path
        expect(page).to have_content 'Lorem ipsum dolor sit amet'
      end
    end

    context 'when missing title' do
      it 'shows current form with entered data and displays error' do
        visit new_kudo_path
        fill_in 'kudo_content', with: 'consectetur adipiscing elit.'
        last_option_reciever = page.find_field('Reciever').all('option').last.text
        page.select last_option_reciever, from: 'kudo_reciever_id'
        last_option_company_value = page.find_field('Company value').all('option').last.text
        page.select last_option_company_value, from: 'kudo_company_value_id'
        click_on 'Save Kudo'
        expect(page).to have_css "form[action='/kudos'][method='post']"
        expect(page).to have_field 'kudo_content', with: 'consectetur adipiscing elit.'
        expect(body).to have_select 'kudo_reciever_id', selected: last_option_reciever
        expect(body).to have_select 'kudo_company_value_id', selected: last_option_company_value
        expect(page).to have_content "Title can't be blank"
      end
    end

    context 'when missing content' do
      it 'shows current form with entered data and displays error' do
        visit new_kudo_path
        fill_in 'kudo_title', with: 'Lorem ipsum dolor sit amet'
        last_option_reciever = page.find_field('Reciever').all('option').last.text
        page.select last_option_reciever, from: 'kudo_reciever_id'
        last_option_company_value = page.find_field('Company value').all('option').last.text
        page.select last_option_company_value, from: 'kudo_company_value_id'
        click_on 'Save Kudo'
        expect(body).to have_css "form[action='/kudos'][method='post']"
        expect(body).to have_select 'kudo_reciever_id', selected: last_option_reciever
        expect(body).to have_select 'kudo_company_value_id', selected: last_option_company_value
        expect(body).to have_field 'kudo_title', with: 'Lorem ipsum dolor sit amet'
        expect(body).to have_content "Content can't be blank"
      end
    end

    context 'when missing reciever' do
      it 'shows current form with entered data and displays error' do
        visit new_kudo_path
        fill_in 'kudo_title', with: 'Lorem ipsum dolor sit amet'
        fill_in 'kudo_content', with: 'consectetur adipiscing elit. Sed dignissim dignissim urna vel ultrices.'
        last_option_company_value = page.find_field('Company value').all('option').last.text
        page.select last_option_company_value, from: 'kudo_company_value_id'
        click_on 'Save Kudo'
        expect(body).to have_css "form[action='/kudos'][method='post']"
        expect(body).to have_select 'kudo_company_value_id', selected: last_option_company_value
        expect(body).to have_field 'kudo_title', with: 'Lorem ipsum dolor sit amet'
        expect(body).to have_content 'Reciever must exist'
      end
    end

    context 'when missing company_value' do
      it 'shows current form with entered data and displays error' do
        visit new_kudo_path
        fill_in 'kudo_title', with: 'Lorem ipsum dolor sit amet'
        fill_in 'kudo_content', with: 'consectetur adipiscing elit. Sed dignissim dignissim urna vel ultrices.'
        last_option_reciever = page.find_field('Reciever').all('option').last.text
        page.select last_option_reciever, from: 'kudo_reciever_id'
        click_on 'Save Kudo'
        expect(body).to have_css "form[action='/kudos'][method='post']"
        expect(body).to have_select 'kudo_reciever_id', selected: last_option_reciever
        expect(body).to have_field 'kudo_title', with: 'Lorem ipsum dolor sit amet'
        expect(body).to have_content 'Company value must exist'
      end
    end
  end
end
