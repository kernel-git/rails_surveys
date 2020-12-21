class SurveysSeeds

  def initialize
  end

  def perform
    surveys = Array.new
    [{
      label: 'University'
    },
    {
      label: 'Social'
    }].each { |hash| surveys << Survey.new(hash) }

    surveys[0].client = Client.find_by(label: 'BSUIR')
    surveys[1].client = Client.find_by(label: 'BSTU')

    surveys[0].question_groups = QuestionGroup.where(id: 1..3)
    surveys[1].question_groups = QuestionGroup.where(id: 4..6)

    begin
      surveys.each(&:save!)
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