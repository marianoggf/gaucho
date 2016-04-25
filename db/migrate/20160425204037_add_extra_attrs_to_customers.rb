class AddExtraAttrsToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :contact_name, :string
    add_column :customers, :phone, :string
    add_column :customers, :observation, :string
  end
end
