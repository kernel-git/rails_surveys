class SurveysSeeds
  def initialize; end

  def perform
    surveys = []
    [{
      label: 'University'
    },
     {
       label: 'Social'
     }].each { |hash| surveys << Survey.new(hash) }

    surveys[0].employer = Employer.find_by(label: 'BSUIR')
    surveys[1].employer = Employer.find_by(label: 'BSTU')

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
