class CreateReceiptCategories < ActiveRecord::Migration
  def change
    create_table :receipt_categories do |t|
      t.string :name
    end
  end
end
