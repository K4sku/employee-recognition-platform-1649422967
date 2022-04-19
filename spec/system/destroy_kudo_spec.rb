require 'rails_helper'

describe 'Kudo.destroy' do
  before do
    driven_by(:selenium)
    current_employee = create(:employee)
    login_as(current_employee, scope: :employee)
    create(:kudo, giver: current_employee)
  end

  context 'when clicking on Destroy link while logged in' do
    context 'when accepting popup' do
      it 'remove kudo' do
        visit root_path
        accept_alert do
          click_link 'Destroy'
        end
        expect(page).to have_current_path kudos_path
        expect(page).to have_no_selector(:css, "tr[id^='kudo_']")
      end
    end

    context 'when rejecting popup' do
      it 'does nothing' do
        visit root_path
        dismiss_confirm do
          click_link 'Destroy'
        end
        expect(page).to have_current_path root_path
        expect(page).to have_selector(:css, "tr[id^='kudo_']")
      end
    end
  end
end
