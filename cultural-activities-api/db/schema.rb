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

ActiveRecord::Schema.define(version: 20220509044249) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cultural_activities", force: :cascade do |t|
    t.string   "title",                     null: false
    t.date     "start_date"
    t.date     "end_date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "description"
    t.string   "detail_url"
    t.string   "image_url"
    t.integer  "web_source_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "status",        default: 1
    t.index ["web_source_id"], name: "index_cultural_activities_on_web_source_id", using: :btree
  end

  create_table "web_sources", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "url",        null: false
    t.string   "slug",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_web_sources_on_name", unique: true, using: :btree
  end

end
