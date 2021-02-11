class CreateOptionStatistics < ActiveRecord::Migration[6.0]
  def change
    create_table :option_statistics do |t|
      t.belongs_to :option
      t.float :chosen_percent, default: -1
    end
  end
end
