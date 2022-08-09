require 'rails_helper'

describe 'Kudo\'s show action', type: :system, js: true do
  include ActiveSupport::Testing::TimeHelpers

  before { sign_in current_employee }

  let!(:current_employee) { create(:employee) }
  let!(:owned_kudo) { create(:kudo, giver: current_employee) }
  let!(:not_owned_kudo) { create(:kudo) }

  context 'when employee is logged in' do
    it 'display owned kudo' do
      visit kudo_path(owned_kudo)
      expect(page).to have_content(owned_kudo.title)
      expect(page).to have_link('Edit')
      expect(page).to have_link('Delete')
      expect(page).to have_link('Back')
    end

    it 'display not owned kudo without edit, delete links' do
      visit kudo_path(not_owned_kudo)
      expect(page).to have_content(not_owned_kudo.title)
      expect(page).to have_no_link('Edit')
      expect(page).to have_no_link('Delete')
      expect(page).to have_link('Back')
    end

    it 'after 5 minutes past kudo\'s creation edit, delete links show error and redirects back' do
      visit kudo_path(owned_kudo)
      travel 5.minutes
      travel 1.second
      click_on 'Edit'
      expect(page).to have_current_path kudo_path(owned_kudo)
      expect(page).to have_content 'You can not perform this action.'
      accept_confirm do
        click_on 'Delete'
      end
      expect(page).to have_current_path kudo_path(owned_kudo)
      expect(page).to have_content 'You can not perform this action.'
    end
  end
end
