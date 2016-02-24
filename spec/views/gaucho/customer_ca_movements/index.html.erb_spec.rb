require 'rails_helper'

RSpec.describe "customer_ca_movements/index", type: :view do
  before(:each) do
    assign(:customer_ca_movements, [
      CustomerCaMovement.create!(
        :amount => "9.99",
        :previous_balance => "9.99",
        :customer => nil,
        :customer_ca_movement_type => nil
      ),
      CustomerCaMovement.create!(
        :amount => "9.99",
        :previous_balance => "9.99",
        :customer => nil,
        :customer_ca_movement_type => nil
      )
    ])
  end

  it "renders a list of customer_ca_movements" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
