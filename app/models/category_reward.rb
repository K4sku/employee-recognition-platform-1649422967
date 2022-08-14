class CategoryReward < ApplicationRecord
  belongs_to :category
  belongs_to :reward

  validates :category_id, uniqueness: { scope: :reward_id }
end
