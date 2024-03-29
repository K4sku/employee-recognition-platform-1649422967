class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  validates :number_of_available_kudos,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :given_kudos, class_name: 'Kudo', foreign_key: 'giver_id', inverse_of: 'giver', dependent: :destroy
  has_many :received_kudos, class_name: 'Kudo', foreign_key: 'reciever_id', inverse_of: 'reciever', dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :rewards, through: :orders

  def points
    received_kudos.count - orders.sum(:purchase_price)
  end
end
