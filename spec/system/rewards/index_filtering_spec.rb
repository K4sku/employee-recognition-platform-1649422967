require 'rails_helper'

describe 'Rewards index display filtered rewards', type: :system do
  let!(:category_with_one_reward) { create(:category_with_rewards, rewards_count: 1) }
  let!(:category_with_nine_rewards) { create(:category_with_rewards, rewards_count: 9) }
  let(:employee) { create(:employee) }

  before do
    sign_in employee
    visit root_path
    click_on 'Rewards'
  end

  context 'when on rewards index page' do
    it 'shows filter links' do
      expect(page).to have_link(category_with_nine_rewards.title)
      expect(page).to have_link(category_with_one_reward.title)
    end

    it 'shows pagination for 4 pages / 10 rewards' do
      expect(page).to have_link('1')
      expect(page).to have_link('2')
      expect(page).to have_link('3')
      expect(page).to have_link('4')
    end
  end

  context 'when filtering by category with one reward' do
    before { click_link category_with_one_reward.title }

    it 'shows one reward' do
      expect(page).to have_selector(:css, "div[test_id^='reward_#{category_with_one_reward.rewards.first.id}']")
    end

    it 'does not show pagination links' do
      expect(page).not_to have_css('nav.pagination')
      expect(page).not_to have_css('a.pagination-link', count: 5)
      expect(page).not_to have_link('Last »')
      expect(page).not_to have_link('« First')
      expect(page).not_to have_link('Next ›')
      expect(page).not_to have_link('‹ Prev')
    end

    it 'resets filtering when clicking on active filter link' do
      click_link category_with_one_reward.title
      expect(page).to have_link('1')
      expect(page).to have_link('2')
      expect(page).to have_link('3')
      expect(page).to have_link('4')
    end
  end

  context 'when filtering by category with nine rewards' do
    before { click_link category_with_nine_rewards.title }

    it 'shows three reward on page' do
      expect(page).to have_selector(:css, "div[test_id^='reward_']", count: 3)
      expect(page).to have_selector(:css, "div[test_id^='reward_#{category_with_nine_rewards.rewards.first.id}']")
      expect(page).to have_selector(:css, "div[test_id^='reward_#{category_with_nine_rewards.rewards.second.id}']")
      expect(page).to have_selector(:css, "div[test_id^='reward_#{category_with_nine_rewards.rewards.third.id}']")
    end

    it 'shows pagination links' do
      expect(page).to have_css('nav.pagination')
      expect(page).to have_css('a.pagination-link', count: 4)
      expect(page).to have_link('Last »')
      expect(page).not_to have_link('« First')
      expect(page).to have_link('Next ›')
      expect(page).not_to have_link('‹ Prev')
    end

    it 'clicking pagination link does not change category' do
      click_link 'Next'
      expect(page.find_link(category_with_nine_rewards.title).ancestor('li')[:class]).to eq('is-active')
    end
  end
end
