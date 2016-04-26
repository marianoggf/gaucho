class CreateReceiptTypes < ActiveRecord::Migration
  def change
    create_table :receipt_types do |t|
      t.string :name
    end
  end
end
