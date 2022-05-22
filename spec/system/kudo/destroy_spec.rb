require 'rails_helper'

describe 'Kudo.destroy', type: :system, js: true do
  before do
    current_employee = create(:employee)
    sign_in current_employee
    create(:kudo, giver: current_employee)
  end

  context 'when clicking on Destroy link while logged in' do
    context 'when accepting popup' do
      it 'remove kudo' do
        visit root_path
        accept_alert do
          click_link 'Delete'
        end
        expect(page).to have_content 'Kudo was successfully destroyed.'
        expect(page).to have_current_path root_path
        expect(page).to have_no_selector(:css, "div[id^='kudo_']")
      end
    end

    context 'when rejecting popup' do
      it 'does nothing' do
        visit root_path
        dismiss_confirm do
          click_link 'Delete'
        end
        expect(page).to have_current_path root_path
        expect(page).to have_selector(:css, "div[id^='kudo_']")
      end
    end
  end
end
