class Reward < ApplicationRecord
  validates :title, :description, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  paginates_per 3
end
