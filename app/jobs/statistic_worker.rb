class StatisticWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

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
        ).count,
        conducted_percent: SurveyEmployeeConnection.filter_by_survey_id(survey_stat.survey.id).count.positive? ?
                            (SurveyEmployeeConnection.filter_by_survey_id(survey_stat.survey.id).filter_conducted.count
                              .fdiv(SurveyEmployeeConnection.filter_by_survey_id(survey_stat.survey.id)
                                .count) * 100).round(2) : -1
      )
    end
    OptionStatistic.find_each do |option_stat|
      question_answers = 0
      option_stat.option.question.options.each { |option| question_answers += option.answers.count }

      option_stat.update!(
        chosen_percent: question_answers.zero? ? -1 : (Answer.where(option: option_stat.option)
          .count.fdiv(question_answers) * 100).round(2)
      )
    end
  end
end