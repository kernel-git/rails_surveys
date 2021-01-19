# frozen_string_literal: true

class RemoveRememberCreatedAt < ActiveRecord::Migration[6.0]
  def self.up
    remove_column :employees, :remember_created_at
    remove_column :employers, :remember_created_at
  end

  def self.down
    add_column :employees, :remember_created_at, :datetime
    add_column :employers, :remember_created_at, :datetime
  end
end
