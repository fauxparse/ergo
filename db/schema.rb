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

ActiveRecord::Schema.define(version: 20150917204033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "effect_cards", force: :cascade do |t|
    t.integer "round_id"
    t.integer "player_id"
    t.integer "target_id"
    t.integer "played_in_turn"
    t.string  "symbol"
    t.integer "rotation",       default: 0
  end

  add_index "effect_cards", ["player_id"], name: "index_effect_cards_on_player_id", using: :btree
  add_index "effect_cards", ["round_id"], name: "index_effect_cards_on_round_id", using: :btree
  add_index "effect_cards", ["target_id"], name: "index_effect_cards_on_target_id", using: :btree

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

  create_table "moves", force: :cascade do |t|
    t.integer "turn_id"
    t.integer "action"
    t.string  "card_type"
    t.text    "options",   default: "{}"
  end

  add_index "moves", ["turn_id"], name: "index_moves_on_turn_id", using: :btree

  create_table "played_cards", force: :cascade do |t|
    t.integer  "premise_id"
    t.integer  "position"
    t.string   "symbol"
    t.integer  "rotation",   default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "played_cards", ["premise_id"], name: "index_played_cards_on_premise_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "position",   default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "score",      default: 0
    t.integer  "user_id"
    t.boolean  "ready",      default: false
  end

  add_index "players", ["user_id"], name: "index_players_on_user_id", using: :btree

  create_table "premises", force: :cascade do |t|
    t.integer "round_id"
    t.integer "position"
  end

  add_index "premises", ["round_id"], name: "index_premises_on_round_id", using: :btree

  create_table "rounds", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "position",        default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "cards_remaining"
    t.integer  "turns_count",     default: 0
    t.integer  "state",           default: 0
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "turns", force: :cascade do |t|
    t.integer  "round_id"
    t.integer  "player_id"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "turns", ["player_id"], name: "index_turns_on_player_id", using: :btree
  add_index "turns", ["round_id"], name: "index_turns_on_round_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "avatar"
    t.string   "provider"
    t.string   "uid"
    t.string   "refresh_token"
    t.string   "access_token"
    t.datetime "expires_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_foreign_key "effect_cards", "players", column: "target_id", on_delete: :cascade
  add_foreign_key "effect_cards", "players", on_delete: :cascade
  add_foreign_key "effect_cards", "rounds", on_delete: :cascade
  add_foreign_key "hands", "players", on_delete: :cascade
  add_foreign_key "hands", "rounds", on_delete: :cascade
  add_foreign_key "moves", "turns", on_delete: :cascade
  add_foreign_key "played_cards", "premises", on_delete: :cascade
  add_foreign_key "players", "users", on_delete: :cascade
  add_foreign_key "premises", "rounds", on_delete: :cascade
  add_foreign_key "rounds", "games", on_delete: :cascade
  add_foreign_key "turns", "players", on_delete: :cascade
  add_foreign_key "turns", "rounds", on_delete: :cascade
end
