FactoryGirl.define do
  factory :customer_category do
    sequence(:name) { |i| "Tipo #{i}" }
  end
end
