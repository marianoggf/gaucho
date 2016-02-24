FactoryGirl.define do
  factory :gaucho_customer_ca_movement, class: 'Gaucho::CustomerCaMovement' do
    amount "9.99"
    previous_balance "9.99"
    date "2016-02-24 11:03:44"
    customer nil
    customer_ca_movement_type nil
  end
end
