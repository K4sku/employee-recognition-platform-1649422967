require 'rails_helper'

describe CompanyValue, type: :model do
  describe 'validations' do
    # rubocop:disable RSpec/ImplicitExpect
    subject { build(:company_value) }

    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title).case_insensitive }
    # rubocop:enable RSpec/ImplicitExpect
  end
end
