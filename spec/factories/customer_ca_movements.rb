FactoryGirl.define do
  factory :customer_ca_movement do
    amount "100"
    date DateTime.now
    customer
    customer_ca_movement_category_id 1
    factory :canceled_customer_ca_movement do
      after(:create) {|instance| instance.update(customer_ca_movement_status_id: 2) }
    end
  end
end