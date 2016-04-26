class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :number
      t.belongs_to :receipt_type, index: true, foreign_key: true
      t.belongs_to :receipt_category, index: true, foreign_key: true
      t.belongs_to :customer, index: true, foreign_key: true
    end
  end
end
