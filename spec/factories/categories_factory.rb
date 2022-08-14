FactoryBot.define do
  factory :category do
    title { generate(:category_title) }
  end
end
