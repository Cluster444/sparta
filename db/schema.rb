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

ActiveRecord::Schema.define(version: 20140909113240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: true do |t|
    t.integer  "player_id"
    t.string   "name"
    t.integer  "x"
    t.integer  "y"
    t.integer  "acropolis"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "level",                   precision: 4, scale: 1
    t.integer  "timber_production"
    t.integer  "bronze_production"
    t.integer  "food_production"
    t.integer  "timber_storage"
    t.integer  "bronze_storage"
    t.integer  "food_storage"
    t.integer  "sort_order",                                      default: 0
    t.datetime "last_battle_reported_at"
    t.boolean  "tripwire",                                        default: false
  end

  add_index "cities", ["player_id"], name: "index_cities_on_player_id", using: :btree

  create_table "level_progresses", force: true do |t|
    t.decimal  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
  end

  add_index "level_progresses", ["city_id"], name: "index_level_progresses_on_city_id", using: :btree

  create_table "players", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "x"
    t.integer  "y"
    t.integer  "user_id"
    t.string   "timezone"
  end

  add_index "players", ["user_id"], name: "index_players_on_user_id", using: :btree

  create_table "raids", force: true do |t|
    t.integer  "city_id"
    t.integer  "timber"
    t.integer  "bronze"
    t.integer  "food"
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "reported_at"
    t.datetime "expires_at"
  end

  add_index "raids", ["city_id"], name: "index_raids_on_city_id", using: :btree

  create_table "scouts", force: true do |t|
    t.integer  "city_id"
    t.integer  "timber"
    t.integer  "bronze"
    t.integer  "food"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "reported_at"
  end

  add_index "scouts", ["city_id"], name: "index_scouts_on_city_id", using: :btree

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
