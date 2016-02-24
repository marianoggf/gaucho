require 'rails_helper'

RSpec.describe "customer_ca_movements/edit", type: :view do
  before(:each) do
    @customer_ca_movement = assign(:customer_ca_movement, CustomerCaMovement.create!(
      :amount => "9.99",
      :previous_balance => "9.99",
      :customer => nil,
      :customer_ca_movement_type => nil
    ))
  end

  it "renders the edit customer_ca_movement form" do
    render

    assert_select "form[action=?][method=?]", customer_ca_movement_path(@customer_ca_movement), "post" do

      assert_select "input#customer_ca_movement_amount[name=?]", "customer_ca_movement[amount]"

      assert_select "input#customer_ca_movement_previous_balance[name=?]", "customer_ca_movement[previous_balance]"

      assert_select "input#customer_ca_movement_customer_id[name=?]", "customer_ca_movement[customer_id]"

      assert_select "input#customer_ca_movement_customer_ca_movement_type_id[name=?]", "customer_ca_movement[customer_ca_movement_type_id]"
    end
  end
end
