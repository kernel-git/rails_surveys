class OptionsSeeds
  QUESTIONS = [
    'science_in_university_one',
    'science_in_university_one',
    'science_in_university_one',
    'science_in_university_two',
    'science_in_university_two',
    'science_in_university_two',
    'science_in_university_two',
    'science_in_university_three',
    'science_in_university_three',
    'science_in_university_three',
    'culture_in_university_one',
    'culture_in_university_one',
    'culture_in_university_two',
    'culture_in_university_two',
    'culture_in_university_two',
    'culture_in_university_two',
    'culture_in_university_two',
    'development_in_university_one',
    'development_in_university_one',
    'development_in_university_two',
    'development_in_university_two',
    'development_in_university_two',
    'development_in_university_two',
    'development_in_university_three',
    'development_in_university_three',
    'development_in_university_three',
    'social_culture_one',
    'social_culture_one',
    'social_culture_two',
    'social_culture_two',
    'social_culture_two',
    'social_culture_two',
    'social_freedom_one',
    'social_freedom_one',
    'social_medical_one',
    'social_medical_one',
    'social_medical_one',
    'social_medical_two',
    'social_medical_two',
    'social_medical_two',
    'social_medical_two',
    'social_medical_three',
    'social_medical_three'
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
    Faker::Lorem.sentence,
  ].freeze

  def initialize
  end

  def perform
    options = Array.new
    43.times do |index|
      option = Option.new({
        question_id: Question.find_by(question_type: QUESTIONS[index]).id,
        text: OPTIONS[index],
      })
      option.has_text_field = OPTIONS[index] == 'Other' ? true : false
      options << option
    end

    begin
      options.each(&:save!)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      puts '--->EXEPTION DURING SAVE<---'
      puts "Exeption type: #{e.class.name}"
      puts "Exeption message: #{e.message}"
      puts '~~~~~~~Stack trace~~~~~~~'
      e.backtrace.each { |line| puts line }
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
    end
  end
end
