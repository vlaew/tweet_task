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

ActiveRecord::Schema.define(version: 20160113193853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tweets", force: :cascade do |t|
    t.integer  "user_id",                 null: false
    t.text     "text"
    t.datetime "created_at",              null: false
    t.integer  "votes_count", default: 0
  end

  add_index "tweets", ["user_id"], name: "index_tweets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string  "name",                     null: false
    t.integer "tweets_count", default: 0
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "tweet_id",   null: false
    t.datetime "created_at", null: false
  end

  add_index "votes", ["tweet_id"], name: "index_votes_on_tweet_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  add_foreign_key "tweets", "users", on_delete: :cascade
  add_foreign_key "votes", "tweets", on_delete: :cascade
  add_foreign_key "votes", "users", on_delete: :cascade
end
