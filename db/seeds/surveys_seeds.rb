# frozen_string_literal: true

class SurveysSeeds
  include LoggerExtension

  SURVEYS = %w[
    University
    Social
  ].freeze
  EMPLOYERS = %w[
    BSUIR
    BSTU
  ].freeze

  def initialize; end

  def perform
    2.times do |index|
      survey = Survey.new({
                            label: SURVEYS[index],
                            employer_id: Employer.find_by(label: EMPLOYERS[index]).id
                          })
      log_errors(survey) unless survey.save
    end
  end
end
