require 'rails_helper'
require 'pundit/rspec'

describe KudoPolicy do
  include ActiveSupport::Testing::TimeHelpers

  let!(:employee) { build(:employee) }
  let(:kudo) { build(:kudo, giver: employee) }

  permissions :giver? do
    it 'grants access if user is kudo\' giver' do
      expect(described_class).to permit(employee, kudo)
    end
  end

  permissions :update?, :edit?, :destroy? do
    it 'grants access if less then 5 minutes elapsed since kudo\'s creation' do
      kudo = create(:kudo, giver: employee)
      travel 3.minutes
      expect(described_class).to permit(employee, kudo)
    end

    it 'denies access if less then 5 minutes elapsed since kudo\'s creation' do
      kudo = create(:kudo, giver: employee)
      travel 6.minutes
      expect(described_class).not_to permit(employee, kudo)
    end
  end
end
