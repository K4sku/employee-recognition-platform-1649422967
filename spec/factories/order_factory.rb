FactoryBot.define do
  factory :order do
    reward
    employee
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
