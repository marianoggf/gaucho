class RenameTableCustomerTypeToCustomerCategory < ActiveRecord::Migration
  def change
    rename_table :customer_ca_movement_types, :customer_ca_movement_categories
    remove_foreign_key :customer_ca_movements, column: "customer_ca_movement_type_id"
    rename_column :customer_ca_movements, :customer_ca_movement_type_id, :customer_ca_movement_category_id
    add_foreign_key :customer_ca_movements, :customer_ca_movement_categories
  end
end


