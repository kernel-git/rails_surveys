class RenameForeignKeys < ActiveRecord::Migration[6.0]
  def change
    rename_column :segments_employees, :user_id, :employee_id
    rename_index :segments_employees, :user_id, :employee_id
    rename_column :survey_employee_relations, :user_id, :employee_id
    rename_index :survey_employee_relations, :user_id, :employee_id
    rename_column :answers, :user_id, :employee_id
    rename_index :answers, :user_id, :employee_id
    rename_column :employers_segments, :client_id, :employer_id
    rename_index :employers_segments, :client_id, :employer_id
    rename_column :surveys, :client_id, :employer_id
    rename_index :surveys, :client_id, :employer_id
  end
end
