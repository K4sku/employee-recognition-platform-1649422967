require 'rails_helper'

describe 'Kudo.index', type: :system, js: true do
  let(:employee) { create(:employee) }

  context 'when employee is logged' do
    it 'show all kudos' do
      create(:kudo)
      current_employee = create(:employee)
      sign_in current_employee
      create(:kudo, giver: current_employee)
      visit root_path
      expect(page).to have_selector(:css, "div[id^='kudo_']", count: 2)
    end

    context "when is kudo's giver" do
      it 'show edit link' do
        create(:kudo)
        current_employee = create(:employee)
        sign_in current_employee
        owned_kudo = create(:kudo, giver: current_employee)
        visit root_path

        within "div[id='kudo_#{owned_kudo.id}']" do
          expect(page).to have_content('Edit')
        end
      end

      it 'show delete link' do
        create(:kudo)
        current_employee = create(:employee)
        sign_in current_employee
        owned_kudo = create(:kudo, giver: current_employee)
        visit root_path

        within "div[id='kudo_#{owned_kudo.id}']" do
          expect(page).to have_content('Delete')
        end
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
