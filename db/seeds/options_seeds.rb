# frozen_string_literal: true

class OptionsSeeds
  include LoggerExtension

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
    'social_medical_three',
    'What is your gender?',
    'What is your gender?',
    'What is your gender?',
    'What is your age?',
    'What is your age?',
    'What is your age?',
    'What is your age?',
    'What is your favourite fast-food place?',
    'What is your favourite fast-food place?',
    'What is your favourite fast-food place?',
    'What is your favourite fast-food place?',
    'How often do you eat fast food?',
    'How often do you eat fast food?',
    'How often do you eat fast food?',
    'How often do you eat fast food?',
    'What time would you normally buy fast food?',
    'What time would you normally buy fast food?',
    'What time would you normally buy fast food?',
    'What time would you normally buy fast food?',
    'What time would you normally buy fast food?',
    'On Average how much would you expect to pay for a fast-food meal?',
    'On Average how much would you expect to pay for a fast-food meal?',
    'On Average how much would you expect to pay for a fast-food meal?',
    'On Average how much would you expect to pay for a fast-food meal?',
    'On Average how much would you expect to pay for a fast-food meal?',
    'Do you enjoy fast-food?',
    'Do you enjoy fast-food?',
    'Why do you eat fast food?',
    'Why do you eat fast food?',
    'Why do you eat fast food?',
    'Why do you eat fast food?',
    'Why do you eat fast food?',
    'Why do you eat fast food?',
    'Why do you eat fast food?',
    'Has fast-food become a basic need for you?',
    'Has fast-food become a basic need for you?',
    'Do you think fast food is unhealthy?',
    'Do you think fast food is unhealthy?',
    'If yes, do you think it\'s more damaging than beneficial to the society?(if no, just leave this question)',
    'If yes, do you think it\'s more damaging than beneficial to the society?(if no, just leave this question)',
    'Do you think this trend will?',
    'Do you think this trend will?',
    'Do you think this trend will?',
    'You find this survey:',
    'You find this survey:',
    'You find this survey:',
    'You find this survey:',
    'You find this survey:'
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
    'Male',
    'Female',
    'Other',
    '12-17',
    '18-24',
    '25-35',
    '36-50',
    'McDonalds',
    'KFC',
    'Burger King',
    'Other',
    'Everyday',
    'Once a week',
    'Once a month',
    'Not very often',
    'Before 12 noon',
    'Between 12-3 pm',
    'Between 3-6 pm',
    'Between 6-9 pm',
    '10 pm or later',
    '20 BYN',
    '30 BYN',
    '40 BYN',
    '50 BYN',
    'More than 50 BYN',
    'Yes',
    'No',
    'Quick service',
    'They’re inexpensive',
    'I like the taste',
    'Offers a variety',
    'I like the environment',
    'I am too busy to cook',
    'Other',
    'Yes',
    'No',
    'Yes',
    'No',
    'Yes',
    'No',
    'Increase',
    'Decrease',
    'Be stable',
    'Very Easy',
    'Easy',
    'Normal',
    'Difficult',
    'Very Difficult'
  ].freeze

  def initialize; end

  def perform
    options = []
    OPTIONS.length.times do |index|
      option = Option.new({
                            question_id: Question.find_by(question_type: QUESTIONS[index]).id,
                            text: OPTIONS[index]
                          })
      option.has_text_field = OPTIONS[index] == 'Other'
      option.build_option_statistic(
        chosen_percent: -1
      )
      options << option
    end

    begin
      options.each(&:save!)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      log_exception(e)
    end
  end
end
