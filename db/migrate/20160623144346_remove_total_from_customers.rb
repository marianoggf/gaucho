class RemoveTotalFromCustomers < ActiveRecord::Migration
  def change
    remove_column :customers, :total, :decimal
  end
end
