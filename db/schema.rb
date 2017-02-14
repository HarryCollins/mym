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

ActiveRecord::Schema.define(version: 20170212162154) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "backs", force: :cascade do |t|
    t.decimal  "original_amount"
    t.decimal  "odds"
    t.boolean  "is_full",           default: false
    t.integer  "user_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "market_outcome_id"
    t.decimal  "current_amount"
    t.index ["market_outcome_id"], name: "index_backs_on_market_outcome_id"
    t.index ["user_id"], name: "index_backs_on_user_id"
  end

  create_table "hits", force: :cascade do |t|
    t.integer "back_id"
    t.integer "lay_id"
    t.index ["back_id"], name: "index_hits_on_back_id"
    t.index ["lay_id"], name: "index_hits_on_lay_id"
  end

  create_table "lays", force: :cascade do |t|
    t.decimal  "original_amount"
    t.decimal  "odds"
    t.boolean  "is_full",           default: false
    t.integer  "user_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "market_outcome_id"
    t.decimal  "current_amount"
    t.index ["market_outcome_id"], name: "index_lays_on_market_outcome_id"
    t.index ["user_id"], name: "index_lays_on_user_id"
  end

  create_table "market_outcomes", force: :cascade do |t|
    t.text     "outcome"
    t.integer  "market_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_id"], name: "index_market_outcomes_on_market_id"
  end

  create_table "market_types", force: :cascade do |t|
    t.string   "mechanism"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "markets", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "market_type_id"
  end

  create_table "user_markets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "market_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "is_founder", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname"
    t.string   "secondname"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

end
