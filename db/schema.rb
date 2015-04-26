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

ActiveRecord::Schema.define(version: 20150426163253) do

  create_table "product_sellers", force: true do |t|
    t.integer  "shopId"
    t.integer  "unitSize"
    t.integer  "unitCost"
    t.integer  "stockCur"
    t.integer  "prodId"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "product_name"
    t.text     "desc"
    t.string   "category"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rCount"
  end

  create_table "reviews", force: true do |t|
    t.integer  "uid"
    t.integer  "rating"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pid"
  end

  create_table "shops", force: true do |t|
    t.string   "shop_name"
    t.string   "address"
    t.string   "category"
    t.string   "owner"
    t.integer  "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "shops", ["email"], name: "index_shops_on_email", unique: true
  add_index "shops", ["reset_password_token"], name: "index_shops_on_reset_password_token", unique: true

  create_table "transactions", force: true do |t|
    t.integer  "shopId"
    t.text     "content"
    t.integer  "totalCost"
    t.date     "dueDate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
