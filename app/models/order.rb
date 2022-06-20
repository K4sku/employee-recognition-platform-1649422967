class Order < ApplicationRecord
  belongs_to :employee
  belongs_to :reward

  validate :can_employee_afford_price, on: :create

  def can_employee_afford_price
    return unless reward.present? && employee.present? && (reward.price > employee.points)

    errors.add(:can_not_afford, 'You can not afford this reward')
  end

  def set_purchase_price
    self.purchase_price = reward.price
  end
end
