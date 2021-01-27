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

ActiveRecord::Schema.define(version: 2021_01_27_075033) do

  create_table "accounts", force: :cascade do |t|
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
    t.string "account_user_type"
    t.integer "account_user_id"
    t.index ["account_user_type", "account_user_id"], name: "index_accounts_on_account_user_type_and_account_user_id"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_accounts_on_unlock_token", unique: true
  end

  create_table "administrators", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
  end

  create_table "answers", force: :cascade do |t|
    t.integer "employee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "option_id"
    t.string "additional_text"
    t.index ["employee_id"], name: "index_answers_on_employee_id"
    t.index ["option_id"], name: "index_answers_on_option_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "account_type"
    t.integer "age"
    t.integer "position_age"
    t.boolean "opt_out"
    t.integer "employer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employer_id"], name: "index_employees_on_employer_id"
  end

  create_table "employees_groups", force: :cascade do |t|
    t.integer "group_id"
    t.integer "employee_id"
    t.index ["employee_id"], name: "index_employees_groups_on_employee_id"
    t.index ["group_id"], name: "index_employees_groups_on_group_id"
  end

  create_table "employers", force: :cascade do |t|
    t.string "label"
    t.string "phone"
    t.text "address"
    t.string "logo_url", default: "", null: false
    t.string "public_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "employers_groups", force: :cascade do |t|
    t.integer "employer_id"
    t.integer "group_id"
    t.index ["employer_id"], name: "index_employers_groups_on_employer_id"
    t.index ["group_id"], name: "index_employers_groups_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "options", force: :cascade do |t|
    t.integer "question_id"
    t.string "text"
    t.boolean "has_text_field"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "question_groups", force: :cascade do |t|
    t.string "label"
    t.integer "survey_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_question_groups_on_survey_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question_type"
    t.integer "benchmark_val"
    t.integer "benchmark_vol"
    t.integer "question_group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_group_id"], name: "index_questions_on_question_group_id"
  end

  create_table "survey_employee_connections", force: :cascade do |t|
    t.boolean "is_conducted", default: false
    t.integer "survey_id"
    t.integer "employee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_survey_employee_connections_on_employee_id"
    t.index ["survey_id"], name: "index_survey_employee_connections_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "employer_id"
    t.index ["employer_id"], name: "index_surveys_on_employer_id"
  end

end
