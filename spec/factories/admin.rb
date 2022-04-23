FactoryBot.define do
  factory :admin do
    email
    password { 'password' }
  end
end
