class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|
      t.belongs_to :question
      t.string :text
      t.boolean :has_text_field
      
      t.timestamps
    end
  end
end
