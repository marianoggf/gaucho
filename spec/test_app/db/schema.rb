# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160426133230) do

  create_table "customer_ca_movement_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "is_income"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "manual"
  end

  create_table "customer_ca_movements", force: :cascade do |t|
    t.decimal  "amount",                                 precision: 10
    t.decimal  "previous_balance",                       precision: 16, scale: 2
    t.datetime "date"
    t.integer  "customer_id",                  limit: 4
    t.integer  "customer_ca_movement_type_id", limit: 4
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
  end

  add_index "customer_ca_movements", ["customer_ca_movement_type_id"], name: "index_customer_ca_movements_on_customer_ca_movement_type_id", using: :btree
  add_index "customer_ca_movements", ["customer_id"], name: "index_customer_ca_movements_on_customer_id", using: :btree

  create_table "customer_types", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "cuit",             limit: 255
    t.string   "address",          limit: 255
    t.decimal  "total",                        precision: 16, scale: 2
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "customer_type_id", limit: 4
    t.string   "contact_name",     limit: 255
    t.string   "phone",            limit: 255
    t.string   "observation",      limit: 255
  end

  add_index "customers", ["customer_type_id"], name: "index_customers_on_customer_type_id", using: :btree

  create_table "receipt_categories", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "receipt_details", force: :cascade do |t|
    t.integer "receipt_id", limit: 4
    t.decimal "quantity",             precision: 16, scale: 2
    t.decimal "unit_price",           precision: 16, scale: 2
    t.decimal "iva",                  precision: 10, scale: 4
  end

  add_index "receipt_details", ["receipt_id"], name: "index_receipt_details_on_receipt_id", using: :btree

  create_table "receipt_types", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "receipts", force: :cascade do |t|
    t.string  "number",              limit: 255
    t.integer "receipt_type_id",     limit: 4
    t.integer "receipt_category_id", limit: 4
    t.integer "customer_id",         limit: 4
  end

  add_index "receipts", ["customer_id"], name: "index_receipts_on_customer_id", using: :btree
  add_index "receipts", ["receipt_category_id"], name: "index_receipts_on_receipt_category_id", using: :btree
  add_index "receipts", ["receipt_type_id"], name: "index_receipts_on_receipt_type_id", using: :btree

  create_table "sale_details", force: :cascade do |t|
    t.decimal  "quantity",                precision: 16, scale: 4
    t.decimal  "unit_price",              precision: 16, scale: 2
    t.decimal  "iva",                     precision: 10, scale: 4
    t.string   "description", limit: 255
    t.integer  "sale_id",     limit: 4
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "sale_details", ["sale_id"], name: "index_sale_details_on_sale_id", using: :btree

  create_table "sales", force: :cascade do |t|
    t.datetime "date"
    t.datetime "prescription_date"
    t.integer  "customer_id",             limit: 4
    t.integer  "customer_ca_movement_id", limit: 4
    t.boolean  "archivable"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "sales", ["customer_ca_movement_id"], name: "index_sales_on_customer_ca_movement_id", using: :btree
  add_index "sales", ["customer_id"], name: "index_sales_on_customer_id", using: :btree

  add_foreign_key "customer_ca_movements", "customer_ca_movement_types"
  add_foreign_key "customer_ca_movements", "customers"
  add_foreign_key "customers", "customer_types"
  add_foreign_key "receipt_details", "receipts"
  add_foreign_key "receipts", "customers"
  add_foreign_key "receipts", "receipt_categories"
  add_foreign_key "receipts", "receipt_types"
  add_foreign_key "sale_details", "sales"
  add_foreign_key "sales", "customer_ca_movements"
  add_foreign_key "sales", "customers"
end
