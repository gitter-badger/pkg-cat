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

ActiveRecord::Schema.define(version: 20140819210144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: true do |t|
    t.integer  "package_id",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "attachments", ["package_id"], name: "index_attachments_on_package_id", using: :btree

  create_table "links", force: true do |t|
    t.string  "name",       default: "", null: false
    t.text    "url",                     null: false
    t.integer "package_id",              null: false
  end

  add_index "links", ["package_id"], name: "index_links_on_package_id", using: :btree

  create_table "packages", force: true do |t|
    t.string   "subject",       default: "", null: false
    t.string   "email",                      null: false
    t.string   "author",        default: "", null: false
    t.text     "bio",           default: "", null: false
    t.string   "twitter",       default: "", null: false
    t.string   "github",        default: "", null: false
    t.string   "blog",          default: "", null: false
    t.text     "description",   default: "", null: false
    t.string   "links",         default: [], null: false, array: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "private_token",              null: false
    t.string   "slug",                       null: false
  end

  add_index "packages", ["slug"], name: "index_packages_on_slug", unique: true, using: :btree

end
