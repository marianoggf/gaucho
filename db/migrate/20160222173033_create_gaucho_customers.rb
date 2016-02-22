class CreateGauchoCustomers < ActiveRecord::Migration
  def change
    create_table :gaucho_customers do |t|
      t.string :name
      t.string :cuit
      t.string :address

      t.timestamps null: false
    end
  end
end
