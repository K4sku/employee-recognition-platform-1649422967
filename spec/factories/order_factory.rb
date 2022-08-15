FactoryBot.define do
  factory :order do
    association :employee, :with_point
    reward factory: :reward, price: 1
    purchase_price { 1 }
    status { :placed }
    created_at { Time.zone.at(0) }

    trait :skip_validate do
      to_create do |instance|
        instance.purchase_price = 0
        instance.save(validate: false)
      end
    end
  end
end
