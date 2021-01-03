class AddIndexToEmployers < ActiveRecord::Migration[6.0]
  def change
    remove_column :employers, :logo_url
    change_table :employers do |t|
      t.string :logo_url, null: false, default: ""
    end
  end
end
