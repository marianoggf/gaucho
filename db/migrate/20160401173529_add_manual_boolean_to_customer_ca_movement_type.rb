class AddManualBooleanToCustomerCaMovementType < ActiveRecord::Migration
  def change
    add_column :customer_ca_movement_types, :manual, :boolean
  end
end
