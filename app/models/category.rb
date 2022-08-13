class Category < ApplicationRecord
  has_many :category_rewards, dependent: :restrict_with_exception
  has_many :rewards, through: :category_rewards
end
