# frozen_string_literal: true

class RenameColumnsInManyToManyTables < ActiveRecord::Migration[6.0]
  def change
    rename_column :segments_users, :segments_id, :segment_id
    rename_column :segments_users, :users_id, :user_id
    rename_index :segments_users, 'segments_id', 'segment_id'
    rename_index :segments_users, 'users_id', 'user_id'

    rename_column :clients_segments, :clients_id, :client_id
    rename_column :clients_segments, :segments_id, :segment_id
    rename_index :segments_users, 'clients_id', 'client_id'
    rename_index :segments_users, 'segments_id', 'segment_id'
  end
end
