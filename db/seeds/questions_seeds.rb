# frozen_string_literal: true

class QuestionsSeeds
  include LoggerExtension

  QUESTIONS = %w[
    science_in_university_one
    science_in_university_two
    science_in_university_three
    culture_in_university_one
    culture_in_university_two
    development_in_university_one
    development_in_university_two
    development_in_university_three
    social_culture_one
    social_culture_two
    social_freedom_one
    social_medical_one
    social_medical_two
    social_medical_three
  ].freeze
  QUESTION_GROUPS = [
    'University: Science',
    'University: Science',
    'University: Science',
    'University: Culture',
    'University: Culture',
    'University: Development',
    'University: Development',
    'University: Development',
    'Social: Culture',
    'Social: Culture',
    'Social: Freedom',
    'Social: Medical',
    'Social: Medical',
    'Social: Medical'
  ].freeze

  def initialize; end

  def perform
    questions = []
    14.times do |index|
      questions << Question.new({
                                  question_type: QUESTIONS[index],
                                  benchmark_val: 1,
                                  benchmark_vol: 1,
                                  question_group_id: QuestionGroup.find_by(label: QUESTION_GROUPS[index]).id
                                })
    end

    begin
      questions.each(&:save!)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      log_exception(e)
    end
  end
end
