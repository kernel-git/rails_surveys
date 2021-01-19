# frozen_string_literal: true

class RenameUsersToAccounts < ActiveRecord::Migration[6.0]
  def change
    rename_table :users, :accounts
  end
end
