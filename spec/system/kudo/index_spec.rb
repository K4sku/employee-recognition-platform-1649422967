require 'rails_helper'

describe 'Kudo.index', type: :system, js: true do
  include ActiveSupport::Testing::TimeHelpers
  let(:employee) { create(:employee) }

  context 'when employee is logged' do
    it 'show all kudos' do
      create(:kudo)
      current_employee = create(:employee)
      sign_in current_employee
      create(:kudo, giver: current_employee)
      visit root_path
      expect(page).to have_selector(:css, "div[test_id^='kudo_']", count: 2)
    end

    context "when is kudo's giver" do
      it 'show edit link' do
        create(:kudo)
        current_employee = create(:employee)
        sign_in current_employee
        owned_kudo = create(:kudo, giver: current_employee)
        visit root_path

        within "div[test_id='kudo_#{owned_kudo.id}']" do
          expect(page).to have_content('Edit')
        end
      end

      it 'show delete link' do
        create(:kudo)
        current_employee = create(:employee)
        sign_in current_employee
        owned_kudo = create(:kudo, giver: current_employee)
        visit root_path

        within "div[test_id='kudo_#{owned_kudo.id}']" do
          expect(page).to have_content('Delete')
        end
      end

      it 'after 5 minutes past kudo\'s creation edit, delete links show error and redirects back' do
        create(:kudo)
        current_employee = create(:employee)
        sign_in current_employee
        owned_kudo = create(:kudo, giver: current_employee)
        visit root_path
        travel 5.minutes
        travel 1.second
        within "div[test_id='kudo_#{owned_kudo.id}']" do
          click_on 'Edit'
        end
        expect(page).to have_current_path root_path
        expect(page).to have_content 'You can not perform this action.'
        within "div[test_id='kudo_#{owned_kudo.id}']" do
          accept_confirm do
            click_on 'Delete'
          end
        end
        expect(page).to have_current_path root_path
        expect(page).to have_content 'You can not perform this action.'
      end
    end

    context "when is not kudo's giver" do
      it 'do not show edit link' do
        create(:kudo)
        sign_in employee
        visit root_path
        expect(page).to have_no_link('Edit')
      end

      it 'do not destroy edit link' do
        create(:kudo)
        sign_in employee
        visit root_path
        expect(page).to have_no_link('Destroy')
      end
    end
  end
end
