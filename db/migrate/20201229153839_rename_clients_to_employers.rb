# frozen_string_literal: true

class RenameClientsToEmployers < ActiveRecord::Migration[6.0]
  def change
    rename_table :clients, :employers
  end
end
