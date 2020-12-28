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

ActiveRecord::Schema.define(version: 2020_12_26_175458) do

  create_table "administrators", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_administrators_on_unlock_token", unique: true
  end

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
    t.string "phone"
    t.text "address"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "logo_url", default: "", null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_clients_on_unlock_token", unique: true
  end

  create_table "clients_segments", force: :cascade do |t|
    t.integer "client_id"
    t.integer "segment_id"
    t.index ["client_id"], name: "index_clients_segments_on_client_id"
    t.index ["segment_id"], name: "index_clients_segments_on_segment_id"
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

  create_table "survey_user_relations", force: :cascade do |t|
    t.boolean "is_conducted"
    t.integer "survey_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_survey_user_relations_on_survey_id"
    t.index ["user_id"], name: "index_survey_user_relations_on_user_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "client_id"
    t.index ["client_id"], name: "index_surveys_on_client_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "account_type"
    t.integer "age"
    t.integer "position_age"
    t.boolean "opt_out"
    t.integer "client_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["client_id"], name: "index_users_on_client_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
