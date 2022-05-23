FactoryBot.define do
  factory :kudo do
    title { 'Kudo Title' }
    content { 'Kudo Content' }
    giver
    reciever
    company_value
  end
end
