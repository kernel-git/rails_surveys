# frozen_string_literal: true

class RenameClientIdToEmployerIdOnEmployees < ActiveRecord::Migration[6.0]
  def change
    rename_column :employees, :client_id, :employer_id
  end
end
