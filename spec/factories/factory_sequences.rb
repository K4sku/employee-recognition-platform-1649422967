FactoryBot.define do
  sequence :employee_email do |n|
    "employee#{n}@test.com"
  end
  sequence :admin_email do |n|
    "admin#{n}@test.com"
  end
  sequence :company_value_title do |n|
    "CValue#{n}"
  end
  sequence :category_title do |n|
    "Category#{n}"
  end
  sequence :reward_title do |n|
    "Reward_#{n}"
  end
end
