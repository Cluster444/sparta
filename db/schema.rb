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

ActiveRecord::Schema.define(version: 20140608024122) do

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
  end

  add_index "cities", ["player_id"], name: "index_cities_on_player_id", using: :btree

  create_table "players", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "raids", force: true do |t|
    t.integer  "city_id"
    t.integer  "player_id"
    t.integer  "timber"
    t.integer  "bronze"
    t.integer  "food"
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "raided_at"
  end

  add_index "raids", ["city_id"], name: "index_raids_on_city_id", using: :btree
  add_index "raids", ["player_id"], name: "index_raids_on_player_id", using: :btree

  create_table "scouts", force: true do |t|
    t.integer  "player_id"
    t.integer  "city_id"
    t.integer  "timber"
    t.integer  "bronze"
    t.integer  "food"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "scouted_at"
  end

  add_index "scouts", ["city_id"], name: "index_scouts_on_city_id", using: :btree
  add_index "scouts", ["player_id"], name: "index_scouts_on_player_id", using: :btree

end
