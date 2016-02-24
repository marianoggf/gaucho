class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :cuit
      t.string :address

      t.timestamps null: false
    end
  end
end
