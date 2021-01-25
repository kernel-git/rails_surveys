# frozen_string_literal: true

class OptionsSeeds
  include LoggerExtension

  QUESTIONS = %w[
    science_in_university_one
    science_in_university_one
    science_in_university_one
    science_in_university_two
    science_in_university_two
    science_in_university_two
    science_in_university_two
    science_in_university_three
    science_in_university_three
    science_in_university_three
    culture_in_university_one
    culture_in_university_one
    culture_in_university_two
    culture_in_university_two
    culture_in_university_two
    culture_in_university_two
    culture_in_university_two
    development_in_university_one
    development_in_university_one
    development_in_university_two
    development_in_university_two
    development_in_university_two
    development_in_university_two
    development_in_university_three
    development_in_university_three
    development_in_university_three
    social_culture_one
    social_culture_one
    social_culture_two
    social_culture_two
    social_culture_two
    social_culture_two
    social_freedom_one
    social_freedom_one
    social_medical_one
    social_medical_one
    social_medical_one
    social_medical_two
    social_medical_two
    social_medical_two
    social_medical_two
    social_medical_three
    social_medical_three
  ].freeze
  OPTIONS = [
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    'Other',
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    'Other',
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    'Other',
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    'Other',
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    'Other',
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    'Other',
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    'Other',
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    Faker::Lorem.sentence,
    'Other',
    Faker::Lorem.sentence,
    Faker::Lorem.sentence
  ].freeze

  def initialize; end

  def perform
    options = []
    43.times do |index|
      option = Option.new({
                            question_id: Question.find_by(question_type: QUESTIONS[index]).id,
                            text: OPTIONS[index]
                          })
      option.has_text_field = OPTIONS[index] == 'Other'
      options << option
    end

    begin
      options.each(&:save!)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      log_exception(e)
    end
  end
end
