FactoryGirl.define do
  factory :customer do
    sequence(:name) { |i| "Client#{i}"}
    sequence(:cuit) { |i| "30-" + i.to_s + "-5a"}
    sequence(:address) { |i| "Av. Siempre Viva #{i}"}
    customer_category CustomerCategory.first
  end
end