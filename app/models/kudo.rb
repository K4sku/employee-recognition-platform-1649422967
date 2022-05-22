class Kudo < ApplicationRecord
  validates :title, :content, presence: true
  belongs_to :giver, class_name: 'Employee', inverse_of: 'given_kudos'
  belongs_to :reciever, class_name: 'Employee', inverse_of: 'received_kudos'
end
