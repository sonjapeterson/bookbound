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

ActiveRecord::Schema.define(version: 20140716195134) do

  create_table "books", force: true do |t|
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "isbn"
    t.text     "summary"
    t.string   "author"
  end

  create_table "contact_forms", force: true do |t|
    t.string   "name"
    t.string   "toemail"
    t.string   "fromemail"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", force: true do |t|
    t.integer  "classic"
    t.integer  "comedy"
    t.integer  "comic"
    t.integer  "educational"
    t.integer  "historical"
    t.integer  "memoir"
    t.integer  "mystery"
    t.integer  "nonfiction"
    t.integer  "poetry"
    t.integer  "pulp"
    t.integer  "romance"
    t.integer  "scifi"
    t.integer  "shortstory"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "groups", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_users", id: false, force: true do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  add_index "groups_users", ["group_id", "user_id"], name: "index_groups_users_on_group_id_and_user_id"
  add_index "groups_users", ["user_id"], name: "index_groups_users_on_user_id"

  create_table "notes", force: true do |t|
    t.integer  "group_id"
    t.string   "pagenumber"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "notes", ["user_id"], name: "index_notes_on_user_id"

  create_table "requests", force: true do |t|
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "requested_id"
    t.integer  "requester_id"
    t.integer  "group_id"
  end

  add_index "requests", ["group_id"], name: "index_requests_on_group_id"
  add_index "requests", ["requested_id"], name: "index_requests_on_requested_id"
  add_index "requests", ["requester_id"], name: "index_requests_on_requester_id"

  create_table "users", force: true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "image"
    t.string   "gender"
    t.string   "location"
    t.text     "description"
    t.text     "fav_books"
    t.text     "fav_genres"
    t.text     "fav_authors"
    t.integer  "age"
  end

end
