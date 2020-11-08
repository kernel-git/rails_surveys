surveys = Array.new
[{
        label: 'University'
    },
    {
        label: 'Social'
}].each { |hash| surveys << Survey.new(hash) }

surveys[0].clients << Client.find_by(label: 'BSUIR')
surveys[0].clients << Client.find_by(label: 'BSU')
surveys[0].clients << Client.find_by(label: 'BSTU')
surveys[0].clients << Client.find_by(label: 'BSMU')
surveys[1].clients << Client.find_by(label: 'BSTU')
surveys[1].clients << Client.find_by(label: 'BSMU')
surveys[1].clients << Client.find_by(label: 'BSAI')

surveys[0].question_groups = QuestionGroup.where(id: 1..3)
surveys[1].question_groups = QuestionGroup.where(id: 4..6)

begin
    surveys.each(&:save!)
rescue => e
    puts '--->EXEPTION DURING SAVE<---'
    puts "Exeption type: #{e.class.name}"
    puts "Exeption message: #{e.message}"
    puts '~~~~~~~Stack trace~~~~~~~'
    e.backtrace.each { |line| puts line }
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
end
