FactoryBot.define do
  factory :order do
    reward
    employee
    status { :placed }
  end
end
