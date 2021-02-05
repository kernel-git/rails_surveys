# frozen_string_literal: true

class AddSurveyEmployeeConnectionIdToAnswers < ActiveRecord::Migration[6.0]
  def change
    change_table :answers do |t|
      t.belongs_to :survey_employee_connection
    end
  end
end
