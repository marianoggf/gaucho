class CreateCustomerCaMovementTypes < ActiveRecord::Migration
  def change
    create_table :customer_ca_movement_types do |t|
      t.string :name
      t.boolean :is_income

      t.timestamps null: false
    end
  end
end
