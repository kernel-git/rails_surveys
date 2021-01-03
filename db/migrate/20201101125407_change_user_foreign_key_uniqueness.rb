class ChangeUserForeignKeyUniqueness < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :employer_id, :integer, unique: true
  end
end
