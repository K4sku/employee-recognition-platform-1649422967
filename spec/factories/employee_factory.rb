FactoryBot.define do
  factory :employee, aliases: %i[giver reciever] do
    email { generate :employee_email }
    password { 'password' }
    number_of_available_kudos { 10 }

    trait :with_point do
      after(:create) { |employee| create(:kudo, reciever: employee) }
    end
  end
end
