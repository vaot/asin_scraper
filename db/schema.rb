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

ActiveRecord::Schema.define(version: 2019_06_21_172833) do

  create_table "products", force: :cascade do |t|
    t.string "status", default: "inactive"
    t.string "asin", limit: 10
    t.string "title"
    t.integer "best_seller_rank"
    t.string "category"
    t.integer "length_in_hundreds"
    t.integer "width_in_hundreds"
    t.integer "height_in_hundreds"
    t.string "amazon_image_url"
    t.index ["asin"], name: "index_products_on_asin", unique: true
  end

  create_table "scraper_expressions", force: :cascade do |t|
    t.string "key", limit: 40
    t.string "expression"
    t.index ["key"], name: "index_scraper_expressions_on_key"
  end

end
