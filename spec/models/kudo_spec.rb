require 'rails_helper'

describe Kudo, type: :model do
  # rubocop:disable RSpec/ImplicitExpect
  describe 'associations' do
    it { should belong_to(:giver).class_name('Employee') }
    it { should belong_to(:reciever).class_name('Employee') }
    it { should belong_to(:company_value).class_name('CompanyValue') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end
  # rubocop:enable RSpec/ImplicitExpect
end
