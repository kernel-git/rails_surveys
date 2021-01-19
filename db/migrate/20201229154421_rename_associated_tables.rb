# frozen_string_literal: true

class RenameAssociatedTables < ActiveRecord::Migration[6.0]
  def change
    rename_table :clients_segments, :employers_segments
    rename_table :survey_user_relations, :survey_employee_relations
    rename_table :segments_users, :segments_employees
  end
end
