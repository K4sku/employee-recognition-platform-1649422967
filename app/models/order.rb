require 'csv'
class Order < ApplicationRecord
  belongs_to :employee
  belongs_to :reward
  enum status: { placed: 0, delivered: 1 }, _suffix: false

  validate :can_employee_afford_price, on: :create

  def can_employee_afford_price
    return unless reward.present? && employee.present? && (reward.price > employee.points)

    errors.add(:can_not_afford, 'You can not afford this reward')
  end

  def self.to_csv
    attributes = %w[employee_id reward_id purchase_price status created_at updated_at]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.find_each do |order|
        csv << attributes.map { |attribute| order.send(attribute) }
      end
    end
  end
end
