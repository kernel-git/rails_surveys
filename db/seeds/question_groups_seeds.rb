# frozen_string_literal: true

class QuestionGroupsSeeds
  include LoggerExtension

  def initialize; end

  def perform
    question_groups = []
    [{
      label: 'University: Science'
    },
     {
       label: 'University: Culture'
     },
     {
       label: 'University: Development'
     },
     {
       label: 'Social: Culture'
     },
     {
       label: 'Social: Freedom'
     },
     {
       label: 'Social: Medical'
     }].each { |hash| question_groups << QuestionGroup.new(hash) }

    question_groups[0].survey = Survey.find(1)
    question_groups[1].survey = Survey.find(1)
    question_groups[2].survey = Survey.find(1)

    question_groups[3].survey = Survey.find(2)
    question_groups[4].survey = Survey.find(2)
    question_groups[5].survey = Survey.find(2)

    begin
      question_groups.each(&:save!)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      log_exception(e)
    end
  end
end
