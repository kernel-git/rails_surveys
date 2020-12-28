class AddIndexToClients < ActiveRecord::Migration[6.0]
  def change
    remove_column :clients, :logo_url
    change_table :clients do |t|
      t.string :logo_url, null: false, default: ""
    end
  end
end
