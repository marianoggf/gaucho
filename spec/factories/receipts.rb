FactoryGirl.define do
  factory :receipt do
    sequence(:number) { |i| "a000-0000#{i}" }
    customer
    receipt_type_id 1
    receipt_category_id 1
  end
end
