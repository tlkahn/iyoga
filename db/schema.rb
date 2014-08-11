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

ActiveRecord::Schema.define(version: 20140811055902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "instructors", force: true do |t|
    t.integer  "user_id"
    t.string   "certificates", default: [], array: true
    t.date     "teach_since"
    t.string   "styles",       default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "messages", force: true do |t|
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible_to_receipient"
  end

  create_table "non_recurring_hours", force: true do |t|
    t.integer  "instructor_id"
    t.datetime "available_hour_start"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "private_class_reviews", force: true do |t|
    t.integer  "private_class_id"
    t.integer  "user_id"
    t.integer  "score"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "private_classes", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "students",   default: [], array: true
    t.datetime "start_time"
    t.string   "style",      default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recurring_available_hour_unavailable_periods", force: true do |t|
    t.integer  "recurring_available_hour_id"
    t.datetime "unavailable_period_start"
    t.datetime "unvailable_period_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recurring_available_hours", force: true do |t|
    t.datetime "starting_time"
    t.integer  "hours_from_week_start"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "instructor_id"
    t.string   "recurring_interval_id"
  end

  create_table "recurring_intervals", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.datetime "practice_since"
    t.string   "phone"
    t.text     "introduction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "styles",         default: [], array: true
    t.string   "college"
    t.string   "language",       default: [], array: true
    t.string   "interest",       default: [], array: true
  end

  create_table "styles", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teacher_reviews", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "user_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
