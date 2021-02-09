class CreateSurveyStatisticTable < ActiveRecord::Migration[6.0]
  def change
    create_table :survey_statistics do |t|
      t.belongs_to :survey
      t.integer :month_assigned, default: 0
      t.integer :month_conducted, default: 0
      t.integer :week_assigned, default: 0
      t.integer :week_conducted, default: 0
      t.integer :day_assigned, default: 0
      t.integer :day_conducted, default: 0
      t.integer :hour_assigned, default: 0
      t.integer :hour_conducted, default: 0
    end
  end
end
