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

ActiveRecord::Schema.define(version: 20150923183725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "badges_sashes", force: :cascade do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id", using: :btree
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id", using: :btree
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id", using: :btree

  create_table "bookmarks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "topic_id"
    t.boolean "done",     default: false
  end

  create_table "cliqs", force: :cascade do |t|
    t.string   "name",                           null: false
    t.boolean  "is_category", default: false
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_main"
    t.string   "color",       default: "ffffff"
    t.string   "cached_name"
    t.integer  "parent_id"
    t.integer  "cliq_p_id"
    t.string   "slug"
  end

  add_index "cliqs", ["ancestry"], name: "index_cliqs_on_ancestry", using: :btree
  add_index "cliqs", ["slug"], name: "index_cliqs_on_slug", unique: true, using: :btree

  create_table "colors", force: :cascade do |t|
    t.string   "name"
    t.string   "color_hex"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "parent_id"
    t.integer  "user_id"
    t.integer  "cliq_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: false
  end

  create_table "followings", force: :cascade do |t|
    t.integer  "parent_id"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "l_categories", force: :cascade do |t|
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mario_levels", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "description"
    t.string   "ss_loc"
    t.integer  "fun_rank"
    t.integer  "puzzle_rank"
    t.integer  "difficulty_rank"
    t.integer  "overall_rank"
    t.integer  "close_vote"
    t.integer  "l_category_id"
    t.string   "level_code"
    t.boolean  "disabled",        default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "mario_ratings", force: :cascade do |t|
    t.integer  "fun"
    t.integer  "puzzle"
    t.integer  "difficulty"
    t.integer  "overall"
    t.integer  "user_id"
    t.integer  "mario_level_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "ip"
  end

  create_table "mario_user_comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "commenter_id"
    t.string   "comment"
    t.integer  "mario_level_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "mario_winners", force: :cascade do |t|
    t.integer  "winner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merit_actions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.text     "target_data"
    t.boolean  "processed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: :cascade do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: :cascade do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: :cascade do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "replies", force: :cascade do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reply_reports", force: :cascade do |t|
    t.integer  "reply_id"
    t.string   "user_comment"
    t.integer  "user_id"
    t.integer  "report_reason_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sashes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topic_reports", force: :cascade do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.string   "user_comment"
    t.integer  "report_reason_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: :cascade do |t|
    t.text     "subject"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "cliq_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "exp",               default: 0,     null: false
    t.boolean  "active",            default: true
    t.string   "remove_reason"
    t.integer  "reports"
    t.boolean  "locked",            default: false
    t.integer  "impressions_count", default: 0
    t.boolean  "sticky",            default: false
    t.string   "slug"
    t.boolean  "opened",            default: false
  end

  add_index "topics", ["slug"], name: "index_topics_on_slug", unique: true, using: :btree

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.integer "cliq_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.boolean  "is_admin",               default: false
    t.string   "provider"
    t.string   "uid"
    t.string   "first"
    t.string   "last"
    t.integer  "sash_id"
    t.integer  "level",                  default: 0
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

end
