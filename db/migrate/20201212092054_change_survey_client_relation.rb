class ChangeSurveyClientRelation < ActiveRecord::Migration[6.0]
  def up
    drop_table :clients_surveys
    change_table :surveys do |t|
      t.belongs_to :client
    end
  end
  def down
    remove_column :surveys, :client_id
    create_table :clients_surveys do |t|
      t.belongs_to :client
      t.belongs_to :survey
    end
  end
end
