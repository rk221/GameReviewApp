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

ActiveRecord::Schema.define(version: 2020_03_07_085444) do

  create_table "games", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "genre_id"
    t.index ["genre_id"], name: "index_games_on_genre_id"
    t.index ["name"], name: "index_games_on_name", unique: true
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.string "description", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_genres_on_name", unique: true
  end

  create_table "likes_for_user_reviews", force: :cascade do |t|
    t.integer "user_id"
    t.integer "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_likes_for_user_reviews_on_review_id"
    t.index ["user_id", "review_id"], name: "index_likes_for_user_reviews_on_user_id_and_review_id", unique: true
    t.index ["user_id"], name: "index_likes_for_user_reviews_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title", limit: 50, null: false
    t.text "comment", limit: 200, null: false
    t.integer "user_id"
    t.integer "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.integer "graphic_rate", limit: 5, default: 1, null: false
    t.integer "sound_rate", limit: 5, default: 1, null: false
    t.integer "management_rate", limit: 5, default: 1, null: false
    t.integer "story_rate", limit: 5, default: 1, null: false
    t.integer "volume_rate", limit: 5, default: 1, null: false
    t.index ["game_id"], name: "index_reviews_on_game_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.string "nickname", limit: 30, default: "名無しさん", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
