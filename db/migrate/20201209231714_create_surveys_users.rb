# frozen_string_literal: true

class CreateSurveysUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :surveys_users
    add_reference :surveys_users, :survey, foreign_key: true
    add_reference :surveys_users, :user, foreign_key: true
  end
end
