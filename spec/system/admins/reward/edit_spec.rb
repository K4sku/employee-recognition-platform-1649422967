require 'rails_helper'

describe 'Reward create action', type: :system, js: true do
  before do
    sign_in admin
  end

  let(:admin) { create(:admin) }
  let!(:reward) { create(:reward) }

  context 'when admin is on index page' do
    it 'Edit Reward link' do
      visit admins_rewards_path
      click_on 'Edit'
      expect(page).to have_current_path edit_admins_reward_path(reward)
    end
  end

  context 'when admin is on new reward page' do
    it 'displays reward form' do
      visit edit_admins_reward_path(reward)
      expect(page).to have_field('Title')
      expect(page).to have_field('Description')
      expect(page).to have_field('Price', type: 'number')
    end
  end

  context 'when creating valid reward' do
    it 'saves reward' do
      visit edit_admins_reward_path(reward)
      fill_in 'Title', with: 'Reward Title 1'
      fill_in 'Description', with: 'Lorem ipsum'
      fill_in 'Price', with: 10
      click_on 'Save Reward'
      expect(page).to have_current_path admins_reward_path(reward)
      expect(page).to have_content('Reward Title 1')
      expect(page).to have_content('Lorem ipsum')
      expect(page).to have_content('Price: 10')
    end
  end

  context 'when failing validations' do
    it 'shows validation errors' do
      visit edit_admins_reward_path(reward)
      fill_in 'Title', with: ''
      fill_in 'Description', with: ''
      fill_in 'Price', with: ''
      click_on 'Save Reward'
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("Price can't be blank")
    end
  end

  it 'can add category' do
    category1 = create(:category)
    category2 = create(:category)
    visit edit_admins_reward_path(reward)
    page.find(:css, "input[test_id='category_input']").click
    page.find(:link, category1.title).click
    page.find(:css, "input[test_id='category_input']").click
    page.find(:link, category2.title).click
    click_on 'Save Reward'
    expect(page).to have_current_path admins_reward_path(reward)
    expect(page).to have_content(reward.title.to_s)
    expect(page).to have_content(reward.description.to_s)
    expect(page).to have_content(reward.price.to_s)
    expect(page).to have_content(reward.categories.first.title)
    expect(page).to have_content(reward.categories.last.title)
    expect(page).to have_content(category1.title)
    expect(page).to have_content(category2.title)
  end

  it 'can remove category' do
    visit edit_admins_reward_path(reward)
    expect(page).to have_css('span.tag', count: 2)
    page.first(:css, 'div.delete').click
    expect(page).to have_css('span.tag', count: 1)
    click_on 'Save Reward'
    expect(page).to have_current_path admins_reward_path(reward)
    expect(page).to have_content(reward.categories.last.title)
    expect(page).to have_css('span.tag', count: 1)
  end

  it 'can not remove all categories' do
    visit edit_admins_reward_path(reward)
    expect(page).to have_css('span.tag', count: 2)
    page.first(:css, 'div.delete').click
    page.first(:css, 'div.delete').click
    expect(page).to have_css('span.tag', count: 0)
    click_on 'Save Reward'
    expect(page).to have_current_path admins_reward_path(reward)
    expect(page).to have_content("Categories can't be blank")
    expect(page).to have_css('span.tag', count: 0)
  end
end
