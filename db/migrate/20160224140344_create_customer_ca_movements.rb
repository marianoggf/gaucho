class CreateCustomerCaMovements < ActiveRecord::Migration
  def change
    create_table :customer_ca_movements do |t|
      t.decimal :amount, precision: 16, scale: 2
      t.decimal :previous_balance, precision: 16, scale: 2
      t.timestamp :date
      t.belongs_to :customer, index: true, foreign_key: true
      t.belongs_to :customer_ca_movement_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
