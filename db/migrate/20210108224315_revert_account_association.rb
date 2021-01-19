# frozen_string_literal: true

class RevertAccountAssociation < ActiveRecord::Migration[6.0]
  def self.up
    remove_index :accounts, :administrator_id
    remove_column :accounts, :administrator_id
    remove_index :accounts, :employer_id
    remove_column :accounts, :employer_id
    remove_index :accounts, :employee_id
    remove_column :accounts, :employee_id
    change_table :administrators do |t|
      t.belongs_to :account
    end
    change_table :employers do |t|
      t.belongs_to :account
    end
    change_table :employees do |t|
      t.belongs_to :account
    end
  end

  def self.down
    remove_index :administrators, :account_id
    remove_column :administrators, :account_id
    remove_index :employers, :account_id
    remove_column :employers, :account_id
    remove_index :employees, :account_id
    remove_column :employees, :account_id
    change_table :accounts do |t|
      t.belongs_to :administrator, optional: true
      t.belongs_to :employer, optional: true
      t.belongs_to :employee, optional: true
    end
  end
end
