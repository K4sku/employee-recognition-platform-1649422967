class CompanyValue < ApplicationRecord
  has_many :kudos, dependent: :destroy
  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
