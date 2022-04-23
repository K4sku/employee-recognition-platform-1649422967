FactoryBot.define do
  factory :employee, aliases: %i[giver reciever] do
    email
    password { 'password' }
    number_of_available_kudos { 10 }
  end
end
