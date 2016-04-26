class CreateReceiptDetails < ActiveRecord::Migration
  def change
    create_table :receipt_details do |t|
      t.belongs_to :receipt, index: true, foreign_key: true
      t.string :description
      t.decimal :quantity, precision: 16, scale: 2
      t.decimal :unit_price, precision: 16, scale: 2
      t.decimal :iva, precision: 10, scale: 4
    end
  end
end
