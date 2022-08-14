FactoryBot.define do
  factory :category do
    title { generate(:category_title) }
  end

  facotry :category_with_rewards do
    rewards {}
  end
end

def category_with_rewards(rewards_count: 2)
  FactoryBot.create(:category) do |category|
    FactoryBot.create_list(:reward, rewards_count, categories: [category])
  end
end
