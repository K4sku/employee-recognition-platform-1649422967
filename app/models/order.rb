require 'csv'

class Order < ApplicationRecord
  belongs_to :employee
  belongs_to :reward
  enum status: { placed: 0, delivered: 1 }, _suffix: false

  validate :can_employee_afford_price, on: :create

  EXPORT_ATTRIBUTES = %w[employee_id reward_id purchase_price status created_at updated_at].freeze

  def can_employee_afford_price
    return unless reward.present? && employee.present? && (reward.price > employee.points)

    errors.add(:can_not_afford, 'You can not afford this reward')
  end

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << EXPORT_ATTRIBUTES
      all.find_each do |order|
        csv << EXPORT_ATTRIBUTES.map { |attribute| order.send(attribute) }
      end
    end
  end
end
