class QuestionGroupsSeeds
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
      puts '--->EXEPTION DURING SAVE<---'
      puts "Exeption type: #{e.class.name}"
      puts "Exeption message: #{e.message}"
      puts '~~~~~~~Stack trace~~~~~~~'
      e.backtrace.each { |line| puts line }
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
    end
  end
end
