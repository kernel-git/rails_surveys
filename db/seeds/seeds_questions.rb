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

questions[0].answers = Answer.where(id: 1..2)
questions[1].answers = Answer.where(id: 3..6)
questions[2].answers = Answer.where(id: 7..8)
questions[3].answers = Answer.where(id: 9..14)
questions[4].answers = Answer.where(id: 15..17)
questions[5].answers = Answer.where(id: 18..19)
questions[6].answers = Answer.where(id: 20..21)
questions[7].answers = Answer.where(id: 22..25)
questions[8].answers = Answer.where(id: 26..28)
questions[9].answers = Answer.where(id: 29..30)
questions[10].answers = Answer.where(id: 31..35)
questions[11].answers = Answer.where(id: 36..38)
questions[12].answers = Answer.where(id: 39..40)
questions[13].answers = Answer.where(id: 41..43)

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
