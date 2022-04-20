FactoryBot.define do
  sequence :email do |n|
    "employee#{n}@test.com"
  end
end
