require 'rails_helper'

describe 'Reward show action', type: :system do
  before do
    sign_in employee
  end

  let(:employee) { create(:employee) }
  let(:reward) { create(:reward) }
  let(:reward_with_image) do
    create(:reward,
           image: fixture_file_upload(Rails.root.join('spec/fixtures/files/valid_reward_image.jpg'), 'image/jpg'))
  end

  context 'when employee is on reward show page' do
    it 'show reward title, description and price' do
      visit reward_path(reward)
      expect(page).to have_content(reward.title)
      expect(page).to have_content(reward.description)
      expect(page).to have_content(reward.price)
    end

    it 'show Back and Claim Reward! links' do
      visit reward_path(reward)
      expect(page).to have_link('Back')
      expect(page).to have_link('CLAIM REWARD!')
    end

    it 'shows image when attached' do
      visit reward_path(reward_with_image)
      expect(page.find('.box')).to have_xpath('//img')
    end
  end
end
