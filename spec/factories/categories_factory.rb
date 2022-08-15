FactoryBot.define do
  factory :category do
    title { generate(:category_title) }

    factory :category_with_rewards do
      transient do
        rewards_count { 2 }
      end

      after(:create) do |category, evaluator|
        create_list(:reward, evaluator.rewards_count, categories: [category])
        category.reload
      end
    end
  end
end
