class CreateSaleDetails < ActiveRecord::Migration
  def change
    create_table :sale_details do |t|
      t.decimal :quantity, precision: 16, scale: 4
      t.decimal :unit_price, precision: 16, scale: 2
      t.decimal :iva, precision: 10, scale: 4
      t.string :description
      t.belongs_to :sale, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
