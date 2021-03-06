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
end
