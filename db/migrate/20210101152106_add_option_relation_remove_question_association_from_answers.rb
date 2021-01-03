class AddOptionRelationRemoveQuestionAssociationFromAnswers < ActiveRecord::Migration[6.0]
  def self.up
    remove_index :answers, :question_id
    remove_column :answers, :question_id
    remove_column :answers, :answer_val
    change_table :answers do |t|
      t.belongs_to :option
      t.string :additional_text
    end
  end
  def self.down
    remove_index :answers, :option_id
    remove_column :answers, :option_id
    remove_column :answers, :additional_text
    change_table :answers do |t|
      t.belongs_to :question
      t.float :answer_val
    end
  end
end
