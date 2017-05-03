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

ActiveRecord::Schema.define(version: 20170503034614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.text "name", null: false
    t.text "motto", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "race_dates", force: :cascade do |t|
    t.date "date", null: false
    t.integer "races", null: false
    t.bigint "track_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_race_dates_on_track_id"
  end

  create_table "race_entries", force: :cascade do |t|
    t.bigint "race_id", null: false
    t.integer "post_position", null: false
    t.text "program_number"
    t.boolean "scratched", null: false
    t.text "jockey"
    t.text "horse_name"
    t.text "horse_color"
    t.integer "horse_birth_year"
    t.integer "morning_odds_numerator"
    t.integer "morning_odds_denominator"
    t.integer "current_odds_numerator"
    t.integer "current_odds_denominator"
    t.decimal "win_payoff"
    t.decimal "place_payoff"
    t.decimal "show_payoff"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_id"], name: "index_race_entries_on_race_id"
  end

  create_table "races", force: :cascade do |t|
    t.bigint "race_date_id", null: false
    t.bigint "track_id", null: false
    t.integer "number", null: false
    t.text "name"
    t.text "distance"
    t.datetime "last_updated_on"
    t.datetime "post_time"
    t.text "surface"
    t.text "track_condition"
    t.text "wager_type"
    t.decimal "exacta_base_bet_amount"
    t.decimal "exacta_payoff_amount"
    t.decimal "trifecta_base_bet_amount"
    t.decimal "trifecta_payoff_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_date_id"], name: "index_races_on_race_date_id"
    t.index ["track_id"], name: "index_races_on_track_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.text "name", null: false
    t.text "timezone"
    t.text "country"
    t.text "horse_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "race_dates", "tracks", name: "fk_race_dates_track"
  add_foreign_key "race_entries", "races", name: "fk_race_entries_race"
  add_foreign_key "races", "race_dates", name: "fk_races_race_date"
  add_foreign_key "races", "tracks", name: "fk_races_track"
end
