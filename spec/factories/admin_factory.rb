FactoryBot.define do
  factory :admin do
    email { generate(:admin_email) }
    password { 'password' }
  end
end
