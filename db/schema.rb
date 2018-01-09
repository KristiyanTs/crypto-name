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

ActiveRecord::Schema.define(version: 20180106104134) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "details", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "organization"
    t.string "job_title"
    t.string "email", null: false
    t.string "phone", null: false
    t.string "fax"
    t.string "address1", null: false
    t.string "address2"
    t.string "city", null: false
    t.string "state"
    t.string "postal_code"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_details_on_user_id"
  end

  create_table "domains", force: :cascade do |t|
    t.string "name", null: false
    t.integer "status", default: 0, null: false
    t.integer "duration", default: 1, null: false
    t.boolean "renewal", default: true, null: false
    t.boolean "privacy", default: false, null: false
    t.string "unlock_code"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_domains_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "notes"
    t.json "info"
    t.string "remote_checkout"
    t.string "remote_id", null: false
    t.string "crypto_currency"
    t.string "crypto_address"
    t.decimal "crypto_amount", precision: 8, scale: 2
    t.decimal "amount", precision: 8, scale: 2
    t.integer "status"
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type", "item_id"], name: "index_transactions_on_item_type_and_item_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "unlock_token"
    t.datetime "locked_at"
    t.decimal "balance", precision: 10, scale: 2, default: "0.0", null: false
    t.boolean "admin", default: false, null: false
    t.string "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
