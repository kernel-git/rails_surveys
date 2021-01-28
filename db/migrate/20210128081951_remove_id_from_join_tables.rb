class RemoveIdFromJoinTables < ActiveRecord::Migration[6.0]
  def self.up
    remove_column :employees_groups, :id
    remove_column :employers_groups, :id
  end
  def self.down
    add_column :employees_groups, :id, :primary_key
    add_column :employers_groups, :id, :primary_key
  end
end
