# frozen_string_literal: true

class AddDeviseToClients < ActiveRecord::Migration[6.0]
  def self.up
    remove_column :clients, :email
    change_table :clients do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

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

      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
    end

    add_index :clients, :email,                unique: true
    add_index :clients, :reset_password_token, unique: true
    # add_index :clients, :confirmation_token,   unique: true
    add_index :clients, :unlock_token,         unique: true
  end

  def self.down
    remove_column :clients, :email
    remove_column :clients, :encrypted_password
    remove_column :clients, :reset_password_token
    remove_column :clients, :reset_password_sent_at
    remove_column :clients, :remember_created_at
    remove_column :clients, :failed_attempts
    remove_column :clients, :unlock_token
    remove_column :clients, :locked_at

    change_table :users do |t|
      t.string :email
    end
  end
end
