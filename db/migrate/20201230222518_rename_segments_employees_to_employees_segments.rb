# frozen_string_literal: true

class RenameSegmentsEmployeesToEmployeesSegments < ActiveRecord::Migration[6.0]
  def change
    rename_table :segments_employees, :employees_segments
  end
end
