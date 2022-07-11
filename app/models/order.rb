class Order < ApplicationRecord
  belongs_to :employee
  belongs_to :reward
  enum status: { placed: 0, delivered: 1 }, _suffix: true

  validate :can_employee_afford_price, on: :create

  def can_employee_afford_price
    return unless reward.present? && employee.present? && (reward.price > employee.points)

    errors.add(:can_not_afford, 'You can not afford this reward')
  end
end
