question_groups = Array.new
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

fake_survey = Survey.new
question_groups.each { |e| e.survey = fake_survey }

begin
    question_groups.each(&:save!)
rescue => e
    puts '--->EXEPTION DURING SAVE<---'
    puts "Exeption type: #{e.class.name}"
    puts "Exeption message: #{e.message}"
    puts '~~~~~~~Stack trace~~~~~~~'
    e.backtrace.each { |line| puts line }
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
end
