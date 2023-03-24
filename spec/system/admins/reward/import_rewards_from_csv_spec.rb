require 'rails_helper'

describe 'import rewards from CSV', type: :system, js: true do
  before do
    sign_in admin
  end

  let(:admin) { create(:admin) }
  let(:reward) { create(:reward) }

  it 'Admin can import rewards from CSV' do
    create(:category, title: 'junk')
    create(:category, title: 'treasure')
    visit admins_root_path
    page.find(:css, "div[test_id='admin_panel']").click
    within(:css, "div[test_id='admin_panel']") do
      click_on 'Rewards'
    end
    click_on 'Import rewards from CSV'
    attach_file('rewards_csv', Rails.root.join('spec/fixtures/files/rewards.csv'))
    check 'headers'
    click_on 'Import selected file'

    expect(page).to have_content 'imported Reward', count: 1
    expect(page).to have_content 'from headers file'
    expect(page).to have_content '1'
    expect(page).to have_content 'junk'

    click_on 'Import rewards from CSV'
    attach_file('rewards_csv', Rails.root.join('spec/fixtures/files/rewards_noheaders.csv'))
    uncheck 'headers'
    click_on 'Import selected file'
    expect(page).to have_content 'imported Reward', count: 1
    expect(page).to have_content 'from no headers file'
    expect(page).to have_content '20'
    expect(page).to have_content 'treasure'
  end
end
