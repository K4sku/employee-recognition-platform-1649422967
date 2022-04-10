class Kudo < ApplicationRecord
  validates :title, :content, presence: true
  belongs_to :giver, class_name: 'Employee'
  belongs_to :reciever, class_name: 'Employee'
end
