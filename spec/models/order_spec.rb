require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:employee) { create(:employee) }

  # rubocop:disable RSpec/ImplicitExpect
  describe 'validations' do
    it { should belong_to(:employee) }
    it { should belong_to(:reward) }
  end
  # rubocop:enable RSpec/ImplicitExpect

  it '.to_csv creates CSV file with proper values and all orders' do
    order = create(:order, :skip_validate)
    expect(described_class.to_csv.lines.count).to be 2 # header row + 1 data row
    expect(described_class.to_csv).to include(CSV.generate_line([
                                                                  order.employee_id,
                                                                  order.reward_id,
                                                                  order.purchase_price,
                                                                  order.status,
                                                                  order.created_at,
                                                                  order.updated_at
                                                                ]))
    create_list(:order, 2, :skip_validate)
    expect(described_class.to_csv.lines.count).to be 4 # header row + 3 data rows
  end
end
