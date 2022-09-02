require 'rails_helper'

describe 'Admin can add image to reward', type: :system, js: true do
  let!(:reward) { create(:reward) }

  before do
    admin = create(:admin)
    sign_in admin
    visit admins_root_path
    page.find(:css, "div[test_id='admin_panel']").click
    within(:css, "div[test_id='admin_panel']") do
      click_on 'Rewards'
    end
    click_on 'Edit'
  end

  context 'when image passes validation' do
    it 'saves attachment' do
      attach_file('reward[image]', Rails.root.join('spec/fixtures/files/valid_reward_image.jpg'))
      click_on 'Save Reward'
      reward.reload
      expect(reward.image).to be_attached
      expect(page).to have_xpath("//img[contains(@src, 'valid_reward_image.jpg')]")
    end
  end

  context 'when image fails validation' do
    it 'does not save image and shows error' do
      attach_file('reward[image]', Rails.root.join('spec/fixtures/files/invalid_reward_image.gif'))
      click_on 'Save Reward'
      reward.reload
      expect(page).to have_content('Only png and jpg images are accepted')
      expect(reward.image).not_to be_attached
      expect(page).not_to have_xpath("//img[contains(@src, 'valid_reward_image.jpg')]")
    end
  end
end
