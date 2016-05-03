class ChangeCustomerTypesToCategories < ActiveRecord::Migration
  def change
    rename_table :customer_types, :customer_categories
    remove_foreign_key :customers, column: "customer_type_id"
    rename_column :customers, :customer_type_id, :customer_category_id
    add_foreign_key :customers, :customer_categories
  end
end
