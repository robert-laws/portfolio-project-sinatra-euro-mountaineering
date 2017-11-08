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

ActiveRecord::Schema.define(version: 4) do

  create_table "clubs", force: :cascade do |t|
    t.string "name"
  end

  create_table "hiker_mountains", force: :cascade do |t|
    t.integer "hiker_id"
    t.integer "mountain_id"
  end

  create_table "hikers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.integer "club_id"
    t.string "username"
    t.string "password_digest"
  end

  create_table "mountains", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.integer "height"
  end

end
