class AddTimestampsToTables < ActiveRecord::Migration[6.0]
  def change
    change_table :employees do |t|
      t.timestamps
    end
    change_table :employers do |t|
      t.timestamps
    end
    change_table :question_groups do |t|
      t.timestamps
    end
    change_table :questions do |t|
      t.timestamps
    end
    change_table :segments do |t|
      t.timestamps
    end
  end
end
