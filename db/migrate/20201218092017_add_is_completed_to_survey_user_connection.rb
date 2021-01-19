# frozen_string_literal: true

class AddIsCompletedToSurveyUserConnection < ActiveRecord::Migration[6.0]
  def up
    drop_table :surveys_users
    create_table :survey_user_relations do |t|
      t.boolean :is_conducted
      t.belongs_to :survey
      t.belongs_to :user

      t.timestamps
    end
  end

  def down
    drop_table :survey_user_relations
    create_table :surveys_users do |t|
      t.belongs_to :survey
      t.belongs_to :user
    end
  end
end
