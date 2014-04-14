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

ActiveRecord::Schema.define(version: 20140414212038) do

  create_table "authentications", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boards", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  add_index "boards", ["key"], name: "index_boards_on_key", unique: true
  add_index "boards", ["owner_id"], name: "index_boards_on_owner_id"

  create_table "commits", force: true do |t|
    t.string   "project"
    t.datetime "committed_at"
    t.string   "sha"
    t.text     "message"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "github_path"
    t.integer  "user_id"
  end

  add_index "commits", ["user_id"], name: "index_commits_on_user_id"

  create_table "user_board_tokens", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "board_id",   null: false
    t.string   "key",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_board_tokens", ["board_id"], name: "index_user_board_tokens_on_board_id"
  add_index "user_board_tokens", ["key"], name: "index_user_board_tokens_on_key", unique: true
  add_index "user_board_tokens", ["user_id"], name: "index_user_board_tokens_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
  end

  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token"

end
