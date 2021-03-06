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

ActiveRecord::Schema.define(version: 20150706142051) do

  create_table "ip_caches", force: :cascade do |t|
    t.string   "ip_address",                  null: false
    t.boolean  "blacklisted", default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "hellbanned",  default: false
    t.string   "user_agent"
    t.string   "referrer"
  end

  add_index "ip_caches", ["ip_address"], name: "index_ip_caches_on_ip_address", unique: true

  create_table "pm_posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "pm_topic_id"
    t.integer  "user_id"
    t.string   "ip_address"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "handshake_sent", default: false
  end

  add_index "pm_posts", ["pm_topic_id"], name: "index_pm_posts_on_pm_topic_id"
  add_index "pm_posts", ["user_id"], name: "index_pm_posts_on_user_id"

  create_table "pm_topics", force: :cascade do |t|
    t.datetime "last_posted"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "sender_handshake",    default: false
    t.boolean  "recipient_handshake", default: false
    t.boolean  "handshake_declined",  default: false
    t.integer  "post_id"
    t.integer  "topic_id"
    t.string   "title"
    t.boolean  "sender_unread",       default: true
    t.boolean  "recipient_unread",    default: true
  end

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "topic_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "quote"
    t.string   "ip_address"
    t.integer  "user_id"
    t.boolean  "contact",    default: false
    t.boolean  "visible",    default: true
    t.boolean  "flagged",    default: false
    t.boolean  "hellbanned", default: false
  end

  add_index "posts", ["topic_id", "created_at"], name: "index_posts_on_topic_id_and_created_at"
  add_index "posts", ["topic_id"], name: "index_posts_on_topic_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "topics", force: :cascade do |t|
    t.text     "title"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.datetime "last_posted"
    t.integer  "user_id"
    t.integer  "views",          default: 0
    t.boolean  "visible",        default: true
    t.boolean  "hellbanned",     default: false
    t.datetime "last_posted_hb"
  end

  add_index "topics", ["user_id"], name: "index_topics_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean  "admin",             default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
