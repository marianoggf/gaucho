FactoryGirl.define do
  factory :customer_ca_movement do
    amount "100"
    date DateTime.now
    customer
  end
end