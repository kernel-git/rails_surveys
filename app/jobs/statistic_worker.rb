class StatisticWorker
  include Sidekiq::Worker

  def perform()
    SurveyStatistic.find_each do |survey_stat|
      survey_stat.update!(
        month_assigned: SurveyEmployeeConnection.where(
          survey: survey_stat.survey,
          updated_at: (DateTime.current - 30.days)..DateTime.current 
        ).count,
        month_conducted: SurveyEmployeeConnection.where(
          survey: survey_stat.survey,
          is_conducted: true,
          updated_at: (DateTime.current - 30.days)..DateTime.current 
        ).count,
        week_assigned: SurveyEmployeeConnection.where(
          survey: survey_stat.survey,
          updated_at: (DateTime.current - 7.days)..DateTime.current 
        ).count,
        week_conducted: SurveyEmployeeConnection.where(
          survey: survey_stat.survey,
          is_conducted: true,
          updated_at: (DateTime.current - 7.days)..DateTime.current 
        ).count,
        day_assigned: SurveyEmployeeConnection.where(
          survey: survey_stat.survey,
          updated_at: (DateTime.current - 1.days)..DateTime.current 
        ).count,
        day_conducted: SurveyEmployeeConnection.where(
          survey: survey_stat.survey,
          is_conducted: true,
          updated_at: (DateTime.current - 1.days)..DateTime.current 
        ).count,
        hour_assigned: SurveyEmployeeConnection.where(
          survey: survey_stat.survey,
          updated_at: (DateTime.current - 1.hours)..DateTime.current 
        ).count,
        hour_conducted: SurveyEmployeeConnection.where(
          survey: survey_stat.survey,
          is_conducted: true,
          updated_at: (DateTime.current - 1.hours)..DateTime.current 
        ).count
      )
    end
  end
end