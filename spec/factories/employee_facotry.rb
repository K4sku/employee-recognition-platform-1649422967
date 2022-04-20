FactoryBot.define do
  factory :employee, aliases: %i[giver reciever] do
    email
    password { 'password' }
  end
end
