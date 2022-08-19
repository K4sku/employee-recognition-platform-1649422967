require 'rails_helper'

describe 'Rewards index display paginated rewards', type: :system, js: true do
  let!(:rewards) { create_list(:reward, 7) }
  let(:employee) { create(:employee) }

  before do
    sign_in employee
    visit root_path
    click_on 'Rewards'
  end

  context 'when on rewards index page' do
    it 'shows rewards ids: 1, 2, 3' do
      expect(page).to have_selector(:css, "div[test_id^='reward_']", count: 3)
      expect(page).to have_selector(:css, "div[test_id^='reward_#{rewards[0].id}']")
      expect(page).to have_selector(:css, "div[test_id^='reward_#{rewards[1].id}']")
      expect(page).to have_selector(:css, "div[test_id^='reward_#{rewards[2].id}']")
    end

    it 'shows Details link' do
      expect(page).to have_link('Show details', count: 3)
    end

    it 'shows pagination links' do
      expect(page).to have_css('nav.pagination')
      expect(page).to have_css('a.pagination-link', count: 4)
      expect(page).to have_link('Last »')
      expect(page).not_to have_link('« First')
      expect(page).to have_link('Next ›')
      expect(page).not_to have_link('‹ Prev')
    end
  end

  context 'when on rewards 2nd page' do
    before do
      within(page.find('nav.pagination')) do
        click_link '2'
      end
    end

    it 'shows rewards ids: 4, 5, 6' do
      expect(page).to have_selector(:css, "div[test_id^='reward_']", count: 3)
      expect(page).to have_selector(:css, "div[test_id^='reward_#{rewards[3].id}']")
      expect(page).to have_selector(:css, "div[test_id^='reward_#{rewards[4].id}']")
      expect(page).to have_selector(:css, "div[test_id^='reward_#{rewards[5].id}']")
    end

    it 'shows pagination links' do
      expect(page).to have_css('nav.pagination')
      expect(page).to have_css('a.pagination-link', count: 5)
      expect(page).to have_link('Last »')
      expect(page).to have_link('« First')
      expect(page).to have_link('Next ›')
      expect(page).to have_link('‹ Prev')
    end
  end

  context 'when on rewards 3nd (final) page' do
    before do
      within(page.find('nav.pagination')) do
        click_link '3'
      end
    end

    it 'shows reward id: 7' do
      expect(page).to have_selector(:css, "div[test_id^='reward_']", count: 1)
      expect(page).to have_selector(:css, "div[test_id^='reward_#{rewards[6].id}']")
    end

    it 'shows pagination links' do
      expect(page).to have_css('nav.pagination')
      expect(page).to have_css('a.pagination-link', count: 4)
      expect(page).not_to have_link('Last »')
      expect(page).to have_link('« First')
      expect(page).not_to have_link('Next ›')
      expect(page).to have_link('‹ Prev')
    end
  end
end
