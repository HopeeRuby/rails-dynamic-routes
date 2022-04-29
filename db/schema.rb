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

ActiveRecord::Schema.define(version: 1) do
  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.string "key"
    t.string "route"
    t.boolean "visible", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.integer "language"
    t.text "description"
    t.string "seo_title"
    t.text "seo_keyword"
    t.text "seo_description"
    t.string "controller", default: "pages"
    t.string "action", default: "show"
    t.string "template", default: "default"
    t.integer "priority", default: 0
    t.string "settings"
    t.index ["parent_id"], name: "index_pages_on_parent_id"
  end
end
