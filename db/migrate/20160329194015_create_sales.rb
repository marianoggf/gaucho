class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.timestamp :date
      t.timestamp :prescription_date
      t.belongs_to :customer, index: true, foreign_key: true
      t.belongs_to :customer_ca_movement, index: true, foreign_key: true
      t.boolean :archivable

      t.timestamps null: false
    end
  end
end