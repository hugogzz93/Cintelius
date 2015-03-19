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

ActiveRecord::Schema.define(version: 20150315221523) do

  create_table "categories", force: true do |t|
    t.integer  "supercategory_id", limit: 4
    t.string   "name",             limit: 255, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "categories", ["supercategory_id"], name: "index_categories_on_supercategory_id", using: :btree

  create_table "combo_products", force: true do |t|
    t.integer  "combo_id",   limit: 4
    t.integer  "units",      limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "product_id", limit: 4
  end

  add_index "combo_products", ["product_id"], name: "index_combo_products_on_product_id", using: :btree

  create_table "combos", force: true do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "order_id",   limit: 4
    t.decimal  "price",                precision: 10,             null: false
    t.integer  "status",     limit: 4,                default: 0, null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "comments", force: true do |t|
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.text     "content",          limit: 65535, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree

  create_table "offer_details", force: true do |t|
    t.integer  "order_id",   limit: 4
    t.integer  "offer_id",   limit: 4
    t.integer  "units",      limit: 4,             null: false
    t.integer  "status",     limit: 4, default: 0, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "offers", force: true do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "product_id",    limit: 4
    t.integer  "status",        limit: 4,                default: 0, null: false
    t.decimal  "unitary_price",           precision: 10,             null: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "order_id",      limit: 4
  end

  add_index "offers", ["order_id"], name: "index_offers_on_order_id", using: :btree

  create_table "order_products", force: true do |t|
    t.integer  "order_id",   limit: 4
    t.integer  "product_id", limit: 4
    t.integer  "units",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "orders", force: true do |t|
    t.string   "title",      limit: 255, null: false
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "product_scores", force: true do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "product_id",    limit: 4
    t.decimal  "total_score",             precision: 10
    t.integer  "total_reviews", limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "products", force: true do |t|
    t.string   "name",        limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "category_id", limit: 4
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "review_tickets", force: true do |t|
    t.integer  "reviewable_id",   limit: 4
    t.string   "reviewable_type", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "user_id",         limit: 4
  end

  add_index "review_tickets", ["reviewable_id", "reviewable_type"], name: "index_review_tickets_on_reviewable_id_and_reviewable_type", using: :btree
  add_index "review_tickets", ["user_id"], name: "index_review_tickets_on_user_id", using: :btree

  create_table "service_scores", force: true do |t|
    t.integer  "user_id",       limit: 4
    t.decimal  "total_score",             precision: 10
    t.integer  "total_reviews", limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "user_details", force: true do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "telephone",    limit: 4
    t.string   "address",      limit: 255
    t.string   "organization", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "credentials",  limit: 4
  end

  create_table "user_products", force: true do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "product_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_products", ["product_id"], name: "index_user_products_on_product_id", using: :btree
  add_index "user_products", ["user_id"], name: "index_user_products_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "sec_email",              limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
