# frozen_string_literal: true

class QuestionsSeeds
  include LoggerExtension

  QUESTIONS = [
    'science_in_university_one',
    'science_in_university_two',
    'science_in_university_three',
    'culture_in_university_one',
    'culture_in_university_two',
    'development_in_university_one',
    'development_in_university_two',
    'development_in_university_three',
    'social_culture_one',
    'social_culture_two',
    'social_freedom_one',
    'social_medical_one',
    'social_medical_two',
    'social_medical_three',
    'What is your gender?',
    'What is your age?',
    'What is your favourite fast-food place?',
    'How often do you eat fast food?',
    'What time would you normally buy fast food?',
    'On Average how much would you expect to pay for a fast-food meal?',
    'Do you enjoy fast-food?',
    'Why do you eat fast food?',
    'Has fast-food become a basic need for you?',
    'Do you think fast food is unhealthy?',
    'If yes, do you think it\'s more damaging than beneficial to the society?(if no, just leave this question)',
    'Do you think this trend will?',
    'You find this survey:'
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
    'Social: Medical',
    'Personal information',
    'Personal information',
    'Fast food consumption',
    'Fast food consumption',
    'Fast food consumption',
    'Fast food consumption',
    'Your opinion about fast food',
    'Your opinion about fast food',
    'Your opinion about fast food',
    'Your opinion about fast food',
    'Your opinion about fast food',
    'Your opinion about fast food',
    'Your opinion about this survey'
  ].freeze

  def initialize; end

  def perform
    questions = []
    (QUESTIONS.length).times do |index|
      questions << Question.new({
                                  question_type: QUESTIONS[index],
                                  benchmark_val: 1,
                                  benchmark_vol: 1,
                                  question_group_id: QuestionGroup.find_by(label: QUESTION_GROUPS[index]).id
                                })
    end

    begin
      questions.each { |question| question.save!(validate: false) }
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      log_exception(e)
    end
  end
end
