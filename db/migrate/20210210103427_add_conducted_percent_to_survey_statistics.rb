class AddConductedPercentToSurveyStatistics < ActiveRecord::Migration[6.0]
  def change
    add_column :survey_statistics, :conducted_percent, :float, default: -1
  end
end
