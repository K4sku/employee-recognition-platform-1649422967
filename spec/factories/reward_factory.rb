FactoryBot.define do
  factory :reward do
    title { 'Reward title' }
    description { 'Reward description' }
    price { 1 }

    factory :reward_with_categories do
      transient do
        categories_count { 2 }
      end

      after(:create) do |reward, evaluator|
        create_list(:category, evaluator.categories_count, rewards: [reward])
        reward.reload
      end
    end
  end
end
