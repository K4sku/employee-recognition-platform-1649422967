require 'rails_helper'

describe 'Reward destroy action', type: :system, js: true do
  before do
    sign_in admin
  end

  let(:admin) { create(:admin) }

  context 'when admin is destroying reward' do
    it 'destroys reward record' do
      create(:reward)
      visit admins_rewards_path
      accept_alert do
        click_on 'Delete', match: :first
      end
      expect(page).to have_current_path admins_rewards_path
      expect(page).not_to have_selector(:css, "div[test_id^='reward_']")
      expect(page).to have_content('Reward was successfully destroyed.')
    end
  end
end
