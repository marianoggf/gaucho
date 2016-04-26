FactoryGirl.define do
  factory :receipt_detail do
    description "Desc"
    quantity 10
    unit_price 10
    iva 21
    receipt
  end
end
