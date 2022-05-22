FactoryBot.define do
  factory :company_value do
    title { generate(:company_value_title) }
  end
end
