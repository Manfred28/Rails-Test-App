# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_19_152549) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amenities", force: :cascade do |t|
    t.string "name"
    t.integer "classification"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hotel_amenities", force: :cascade do |t|
    t.bigint "hotel_id"
    t.bigint "amenity_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["amenity_id"], name: "index_hotel_amenities_on_amenity_id"
    t.index ["hotel_id"], name: "index_hotel_amenities_on_hotel_id"
  end

  create_table "hotel_suppliers", force: :cascade do |t|
    t.bigint "hotel_id"
    t.bigint "supplier_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotel_id"], name: "index_hotel_suppliers_on_hotel_id"
    t.index ["supplier_id"], name: "index_hotel_suppliers_on_supplier_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "destination_id"
    t.jsonb "location", default: {}
    t.jsonb "denorm_amenities", default: {}
    t.jsonb "images", default: {}
    t.jsonb "booking_conditions", default: []
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "supplier_code"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
