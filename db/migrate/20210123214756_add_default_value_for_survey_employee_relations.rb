class AddDefaultValueForSurveyEmployeeRelations < ActiveRecord::Migration[6.0]
  def change
    change_column :survey_employee_relations, :is_conducted, :boolean, default: false
  end
end
