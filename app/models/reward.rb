class Reward < ApplicationRecord
  has_many :category_rewards, dependent: :destroy
  has_many :categories, through: :category_rewards
  has_one_attached :image

  validates :title, :description, :price, :categories, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validate :image_format

  paginates_per 3

  private

  def image_format
    return unless image.attached?
    return if %w[image/png image/jpg image/jpeg].include?(image.blob.content_type)

    errors.add(:image, 'has to be png or jpg')
  end
end
