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

ActiveRecord::Schema.define(version: 20150911030019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer  "players_count", default: 0
    t.integer  "rounds_count",  default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "hands", force: :cascade do |t|
    t.integer "player_id"
    t.string  "cards_array", default: [], array: true
    t.integer "round_id"
  end

  add_index "hands", ["round_id"], name: "index_hands_on_round_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "position",   default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "rounds", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "position",        default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "cards_remaining"
  end

  add_foreign_key "hands", "players", on_delete: :cascade
  add_foreign_key "hands", "rounds", on_delete: :cascade
  add_foreign_key "rounds", "games", on_delete: :cascade
end
