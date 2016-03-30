FactoryGirl.define do
  factory :customer do
    sequence(:name) { |i| "Client#{i}"}
    sequence(:cuit) { |i| "30-" + i.to_s + "-5"}
    sequence(:address) { |i| "Av. Siempre Viva #{i}"}
    total 0
    factory :altair_customer do
      business_name "Altair"
      cuit "30-615642612-5"
      address "Rep. del libano 56"
    end
  end
end