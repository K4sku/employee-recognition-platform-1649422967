class Reward < ApplicationRecord
  has_many :category_rewards, dependent: :restrict_with_exception
  has_many :categories, through: :category_rewards

  validates :title, :description, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :categories, presence: true

  paginates_per 3
end
