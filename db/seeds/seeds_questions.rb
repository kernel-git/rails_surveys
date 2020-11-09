questions = Array.new
[{
        question_type: 'science_in_university_one',
        benchmark_val: 1,
        benchmark_vol: 1
    },
    {
        question_type: 'science_in_university_two',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'science_in_university_three',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'culture_in_university_one',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'culture_in_university_two',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'development_in_university_one',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'development_in_university_two',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'development_in_university_three',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'social_culture_one',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'social_culture_two',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'social_freedom_one',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'social_medical_one',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'social_medical_two',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'social_medical_three',
        benchmark_val: 2,
        benchmark_vol: 2
}].each { |hash| questions << Question.new(hash) }

questions[0..2].each { |e| e.question_group = QuestionGroup.find_by(label: 'University: Science') }
questions[3, 4].each { |e| e.question_group = QuestionGroup.find_by(label: 'University: Culture') }
questions[5..7].each { |e| e.question_group = QuestionGroup.find_by(label: 'University: Development') }
questions[8, 9].each { |e| e.question_group = QuestionGroup.find_by(label: 'Social: Culture')
questions[10].question_group = QuestionGroup.find_by(label: 'Social: Freedom') }
questions[11..13].each { |e| e.question_group = QuestionGroup.find_by(label: 'Social: Medical') }

fake_user = User.new
questions.each do |e|
    e.answers.each { |answ| answ.user = fake_user }
    e.answers.each(&:save!)
end


begin
    questions.each(&:save!)
rescue => e
    puts '--->EXEPTION DURING SAVE<---'
    puts "Exeption type: #{e.class.name}"
    puts "Exeption message: #{e.message}"
    puts '~~~~~~~Stack trace~~~~~~~'
    e.backtrace.each { |line| puts line }
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
end
