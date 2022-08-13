class Category < ApplicationRecord
  has_many :categories_rewards, dependent: :restrict_with_exception, class_name: 'CategoriesRewards'
  has_many :rewards, through: :categories_rewards, dependent: :restrict_with_exception
end
