class ChangedColumnsForAccountUserPolymorphic < ActiveRecord::Migration[6.0]
  def self.up
    remove_index :administrators, :account_id
    remove_column :administrators, :account_id
    remove_index :employers, :account_id
    remove_column :employers, :account_id
    remove_index :employees, :account_id
    remove_column :employees, :account_id
    remove_column :accounts, :account_type
    change_table :accounts do |t|
      t.references :account_user, polymorphic: true
    end
  end

  def self.down
    remove_index :accounts, %i[account_user_type account_user_id]
    add_column :accounts, :account_type, :string
    remove_column :accounts, :account_user_id

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
end
