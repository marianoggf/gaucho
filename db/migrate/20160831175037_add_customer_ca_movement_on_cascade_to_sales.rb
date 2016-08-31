class AddCustomerCaMovementOnCascadeToSales < ActiveRecord::Migration
  def change
    remove_foreign_key :sales, :customer_ca_movements
    add_foreign_key :sales, :customer_ca_movements , on_delete: :cascade
  end
end
