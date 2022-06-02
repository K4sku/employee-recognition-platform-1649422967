require 'rails_helper'

describe 'Rewards index display all rewards', type: :system do
  before do
    sign_in employee
  end

  let(:employee) { create(:employee) }

  context 'when employee is on rewards index page' do
    it 'shows all rewards' do
      create_list(:reward, 3)
      visit rewards_path
      expect(page).to have_selector(:css, "div[test_id^='reward_']", count: 3)
    end
  end

  it 'shows Details link' do
    create(:reward)
    visit rewards_path
    expect(page).to have_link('Show details')
  end
end
