class RemoveDeviseOnEmployers < ActiveRecord::Migration[6.0]
  def self.up
    remove_index :employers, :email
    remove_index :employers, :reset_password_token
    remove_index :employers, :unlock_token
    remove_column :employers, :email
    remove_column :employers, :encrypted_password
    remove_column :employers, :reset_password_token
    remove_column :employers, :reset_password_sent_at
    remove_column :employers, :failed_attempts
    remove_column :employers, :unlock_token
    remove_column :employers, :locked_at
    change_table :employers do |t|
      t.string :public_email
    end
  end

  def self.down
    remove_column :employers, :public_email
    change_table :employers do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at
    end
    add_index :employers, :email,                unique: true
    add_index :employers, :reset_password_token, unique: true
    # add_index :employers, :confirmation_token,   unique: true
    add_index :employers, :unlock_token,         unique: true
  end
end
