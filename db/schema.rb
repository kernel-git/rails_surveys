# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_01_130404) do

  create_table "answers", force: :cascade do |t|
    t.float "answer_val"
    t.integer "question_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "label"
    t.string "email"
    t.string "phone"
    t.text "address"
    t.string "logo_url"
  end

  create_table "clients_segments", force: :cascade do |t|
    t.integer "client_id"
    t.integer "segment_id"
    t.index ["client_id"], name: "index_clients_segments_on_client_id"
    t.index ["segment_id"], name: "index_clients_segments_on_segment_id"
  end

  create_table "clients_surveys", force: :cascade do |t|
    t.integer "client_id"
    t.integer "survey_id"
    t.index ["client_id"], name: "index_clients_surveys_on_client_id"
    t.index ["survey_id"], name: "index_clients_surveys_on_survey_id"
  end

  create_table "question_groups", force: :cascade do |t|
    t.string "label"
    t.integer "survey_id"
    t.index ["survey_id"], name: "index_question_groups_on_survey_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question_type"
    t.integer "benchmark_val"
    t.integer "benchmark_vol"
    t.integer "question_group_id"
    t.index ["question_group_id"], name: "index_questions_on_question_group_id"
  end

  create_table "segments", force: :cascade do |t|
    t.string "label"
  end

  create_table "segments_users", force: :cascade do |t|
    t.integer "segment_id"
    t.integer "user_id"
    t.index ["segment_id"], name: "index_segments_users_on_segment_id"
    t.index ["user_id"], name: "index_segments_users_on_user_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.string "account_type"
    t.integer "age"
    t.integer "position_age"
    t.boolean "opt_out"
    t.integer "client_id"
    t.index ["client_id"], name: "index_users_on_client_id"
  end

end