class ChangeSurveyEmployerRelation < ActiveRecord::Migration[6.0]
  def up
    drop_table :employers_surveys
    change_table :surveys do |t|
      t.belongs_to :employer
    end
  end
  def down
    remove_column :surveys, :employer_id
    create_table :employers_surveys do |t|
      t.belongs_to :employer
      t.belongs_to :survey
    end
  end
end
