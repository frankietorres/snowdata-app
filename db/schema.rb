# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_15_003653) do
  create_table "lifts", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.integer "resort_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resort_id"], name: "index_lifts_on_resort_id"
  end

  create_table "resorts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "snotel_providers", force: :cascade do |t|
    t.integer "weather_station_provider_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["weather_station_provider_id"], name: "index_snotel_providers_on_weather_station_provider_id"
  end

  create_table "snotel_weather_observations", force: :cascade do |t|
    t.date "date"
    t.time "time"
    t.float "temp"
    t.float "max_temp"
    t.float "min_temp"
    t.float "wind_speed"
    t.integer "wind_direction"
    t.float "wind_gust_speed"
    t.float "melted_precipitation_1hr"
    t.float "snow_height"
    t.float "snow_water_equivalent"
    t.integer "snotel_weather_station_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["snotel_weather_station_id"], name: "index_snotel_weather_observations_on_snotel_weather_station_id"
  end

  create_table "snotel_weather_stations", force: :cascade do |t|
    t.string "name"
    t.float "elevation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trails", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.integer "lift_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lift_id"], name: "index_trails_on_lift_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weather_station_providers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "lifts", "resorts"
  add_foreign_key "snotel_providers", "weather_station_providers"
  add_foreign_key "snotel_weather_observations", "snotel_weather_stations"
  add_foreign_key "trails", "lifts"
end
