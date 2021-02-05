# frozen_string_literal: true

class RenameMultipleTables < ActiveRecord::Migration[6.0]
  def change
    rename_table :segments, :groups
    rename_table :survey_employee_relations, :survey_employee_connections
    rename_table :employees_segments, :employees_groups
    rename_table :employers_segments, :employers_groups
    rename_column :employees_groups, :segment_id, :group_id
    rename_index :employees_groups, :segment_id, :group_id
    rename_column :employers_groups, :segment_id, :group_id
    rename_index :employers_groups, :segment_id, :group_id
  end
end
