class RemovePrescriptionDateFromSales < ActiveRecord::Migration
  def change
    remove_column :sales, :prescription_date, :timestamp
  end
end
