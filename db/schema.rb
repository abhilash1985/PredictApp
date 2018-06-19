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

ActiveRecord::Schema.define(version: 20180619185746) do

  create_table "challenges", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "tournament_id", limit: 4
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "challenges", ["end_time"], name: "index_challenges_on_end_time", using: :btree
  add_index "challenges", ["name"], name: "index_challenges_on_name", using: :btree
  add_index "challenges", ["start_time"], name: "index_challenges_on_start_time", using: :btree
  add_index "challenges", ["tournament_id"], name: "index_challenges_on_tournament_id", using: :btree

  create_table "match_questions", force: :cascade do |t|
    t.integer  "match_id",    limit: 4
    t.integer  "question_id", limit: 4
    t.text     "options",     limit: 65535
    t.string   "answer",      limit: 255
    t.integer  "points",      limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "match_questions", ["answer"], name: "index_match_questions_on_answer", using: :btree
  add_index "match_questions", ["match_id"], name: "index_match_questions_on_match_id", using: :btree
  add_index "match_questions", ["points"], name: "index_match_questions_on_points", using: :btree
  add_index "match_questions", ["question_id"], name: "index_match_questions_on_question_id", using: :btree

  create_table "matches", force: :cascade do |t|
    t.integer  "match_no",     limit: 4
    t.integer  "team1_id",     limit: 4
    t.integer  "team2_id",     limit: 4
    t.integer  "stadium_id",   limit: 4
    t.integer  "challenge_id", limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.datetime "match_date"
    t.integer  "round_id",     limit: 4
    t.integer  "team1_score",  limit: 4,   default: 0
    t.integer  "team2_score",  limit: 4,   default: 0
    t.string   "won_in",       limit: 255, default: "FT"
  end

  add_index "matches", ["challenge_id"], name: "index_matches_on_challenge_id", using: :btree
  add_index "matches", ["match_date"], name: "index_matches_on_match_date", using: :btree
  add_index "matches", ["match_no"], name: "index_matches_on_match_no", using: :btree
  add_index "matches", ["stadium_id"], name: "index_matches_on_stadium_id", using: :btree
  add_index "matches", ["team1_id"], name: "index_matches_on_team1_id", using: :btree
  add_index "matches", ["team2_id"], name: "index_matches_on_team2_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "first_name",   limit: 255
    t.string   "last_name",    limit: 255
    t.integer  "team_id",      limit: 4
    t.date     "dob"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "player_style", limit: 255, default: "bat"
  end

  add_index "players", ["first_name"], name: "index_players_on_first_name", using: :btree
  add_index "players", ["last_name"], name: "index_players_on_last_name", using: :btree
  add_index "players", ["player_style"], name: "index_players_on_player_style", using: :btree

  create_table "predictions", force: :cascade do |t|
    t.integer  "user_challenge_id", limit: 4
    t.integer  "match_question_id", limit: 4
    t.string   "user_answer",       limit: 255
    t.integer  "points",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "predictions", ["match_question_id"], name: "index_predictions_on_match_question_id", using: :btree
  add_index "predictions", ["points"], name: "index_predictions_on_points", using: :btree
  add_index "predictions", ["user_answer"], name: "index_predictions_on_user_answer", using: :btree
  add_index "predictions", ["user_challenge_id"], name: "index_predictions_on_user_challenge_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "question",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "weightage",  limit: 4
  end

  add_index "questions", ["question"], name: "index_questions_on_question", using: :btree
  add_index "questions", ["weightage"], name: "index_questions_on_weightage", using: :btree

  create_table "rounds", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "rounds", ["name"], name: "index_rounds_on_name", using: :btree

  create_table "stadia", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "stadia", ["name"], name: "index_stadia_on_name", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "rank",       limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "short_name", limit: 255
    t.string   "flag",       limit: 255
  end

  add_index "teams", ["name"], name: "index_teams_on_name", using: :btree
  add_index "teams", ["short_name"], name: "index_teams_on_short_name", using: :btree

  create_table "tournaments", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "location",   limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "tournaments", ["end_date"], name: "index_tournaments_on_end_date", using: :btree
  add_index "tournaments", ["name"], name: "index_tournaments_on_name", using: :btree
  add_index "tournaments", ["start_date"], name: "index_tournaments_on_start_date", using: :btree

  create_table "user_challenges", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "challenge_id", limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "paid",         limit: 1, default: false
  end

  add_index "user_challenges", ["challenge_id"], name: "index_user_challenges_on_challenge_id", using: :btree
  add_index "user_challenges", ["user_id"], name: "index_user_challenges_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "middle_name",            limit: 255
    t.string   "last_name",              limit: 255
    t.boolean  "admin",                  limit: 1
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
