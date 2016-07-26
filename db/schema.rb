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

ActiveRecord::Schema.define(version: 20160726213138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "degree_before"
    t.integer  "degree_after"
    t.string   "birth_name"
    t.string   "birth_date"
    t.integer  "gender"
    t.string   "birth_place"
    t.string   "birth_number"
    t.string   "nationality"
    t.integer  "family_status"
    t.string   "bank_acc"
    t.string   "insurance"
    t.string   "occupation"
    t.boolean  "terms"
    t.integer  "status"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "brigades", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "position_id"
    t.integer  "quantity"
    t.boolean  "visible"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "brigades", ["event_id"], name: "index_brigades_on_event_id", using: :btree
  add_index "brigades", ["position_id"], name: "index_brigades_on_position_id", using: :btree

  create_table "event_addresses", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "street"
    t.string   "street_number"
    t.string   "city"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "event_addresses", ["event_id"], name: "index_event_addresses_on_event_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.string   "start_date"
    t.string   "end_date"
    t.integer  "manager"
    t.boolean  "visible"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "positions", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "requirements"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "brigade_id"
    t.integer  "user_id"
    t.boolean  "approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscriptions", ["brigade_id"], name: "index_subscriptions_on_brigade_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "role"
    t.integer  "status"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "accounts", "users"
  add_foreign_key "brigades", "events"
  add_foreign_key "brigades", "positions"
  add_foreign_key "event_addresses", "events"
  add_foreign_key "events", "users"
  add_foreign_key "subscriptions", "brigades"
  add_foreign_key "subscriptions", "users"
end
