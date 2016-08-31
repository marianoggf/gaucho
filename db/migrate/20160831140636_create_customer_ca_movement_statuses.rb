class CreateCustomerCaMovementStatuses < ActiveRecord::Migration
  def change
    create_table :customer_ca_movement_statuses do |t|
      t.string :name, unique: true, null: false
      t.integer :code, unique: true, null: false
    end

    add_reference :customer_ca_movements, :customer_ca_movement_status, index: true, foreign_key: true
  end
end
