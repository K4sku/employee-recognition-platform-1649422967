FactoryBot.define do
  factory :employee do
    email
    password { 'password' }
  end
end
