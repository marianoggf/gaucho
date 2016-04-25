class AddCustomerTypeToCustomer < ActiveRecord::Migration
  def change
    add_reference :customers, :customer_type, index: true, foreign_key: true
  end
end
