FactoryGirl.define do
  factory :customer_type do
    sequence(:name) { |i| "Tipo #{i}" }
  end
end
