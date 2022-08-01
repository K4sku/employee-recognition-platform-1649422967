FactoryBot.define do
  factory :order do
    reward
    employee
    status { :placed }
    created_at { Time.zone.at(0) }
  end
end
