class Reward < ApplicationRecord
  has_many :categories_rewards, dependent: :restrict_with_exception, class_name: 'CategoriesRewards'
  has_many :categories, through: :categories_rewards, dependent: :nullify

  validates :title, :description, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  paginates_per 3
end
