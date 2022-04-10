FactoryBot.define do
  factory :kudo do
    title { 'Kudo Title' }
    content { 'Kudo Content' }
    giver { :employee }
    reciever { :employee }
  end
end
