FactoryBot.define do
  factory :reward do
    transient do
      categories_count { 2 }
    end

    title { generate(:reward_title) }
    description { 'Reward description' }
    price { 1 }

    before(:create) do |reward, evaluator|
      reward.save(validate: false)
      reward.categories << create_list(:category, evaluator.categories_count, rewards: [])
    end
  end
end
