# frozen_string_literal: true

class SurveysSeeds
  include LoggerExtension

  SURVEYS = [
    'University',
    'Social',
    'Fast food'
  ].freeze
  EMPLOYERS = %w[
    BSUIR
    BSTU
    BSUIR
  ].freeze

  def initialize; end

  def perform
    SURVEYS.length.times do |index|
      survey = Survey.new({
                            label: SURVEYS[index],
                            employer_id: Employer.find_by(label: EMPLOYERS[index]).id
                          })
      survey.build_survey_statistic(
        survey: survey
      )
      log_errors(survey) unless survey.save(validate: false)
    end
  end
end
