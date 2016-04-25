class CreateCustomerType < ActiveRecord::Migration
  def change
    create_table :customer_types do |t|
      t.string :name
    end
  end
end
