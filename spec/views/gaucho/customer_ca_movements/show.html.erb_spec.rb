require 'rails_helper'

RSpec.describe "customer_ca_movements/show", type: :view do
  before(:each) do
    @customer_ca_movement = assign(:customer_ca_movement, CustomerCaMovement.create!(
      :amount => "9.99",
      :previous_balance => "9.99",
      :customer => nil,
      :customer_ca_movement_type => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
