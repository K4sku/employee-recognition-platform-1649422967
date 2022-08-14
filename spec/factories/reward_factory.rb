FactoryBot.define do
  factory :reward do
    title { 'Reward title' }
    description { 'Reward description' }
    price { 1 }
  end
end

def reward_with_categories(categories_count: 2)
  FactoryBot.create(:reward) do |reward|
    FactoryBot.create_list(:category, categories_count, categories: [reward])
  end
end
