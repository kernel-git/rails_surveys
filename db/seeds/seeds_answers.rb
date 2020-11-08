answers = Array.new
[{
        answer_val: 0.0,
    },
    {
        answer_val: 0.5,
    },
    {
        answer_val: 1.0,
    },
    {
        answer_val: 1.0,
    },
    {
        answer_val: 1.0,
    },
    {
        answer_val: 1.5,
    },
    {
        answer_val: 2.0,
    },
    {
        answer_val: 2.5,
    },
    {
        answer_val: 3.0,
    },
    {
        answer_val: 3.0,
    },
    {
        answer_val: 3.0,
    },
    {
        answer_val: 3.0,
    },
    {
        answer_val: 3.5,
    },
    {
        answer_val: 3.5,
    },
    {
        answer_val: 4.0,
    },
    {
        answer_val: 4.5,
    },
    {
        answer_val: 4.5,
    },
    {
        answer_val: 5.0,
    },
    {
        answer_val: 5.5,
    },
    {
        answer_val: 6.0,
    },
    {
        answer_val: 6.5,
    },
    {
        answer_val: 7.0,
    },
    {
        answer_val: 7.5,
    },
    {
        answer_val: 7.5,
    },
    {
        answer_val: 7.5,
    },
    {
        answer_val: 8.0,
    },
    {
        answer_val: 8.0,
    },
    {
        answer_val: 8.5,
    },
    {
        answer_val: 9.0,
    },
    {
        answer_val: 9.5,
    },
    {
        answer_val: 10.0,
    },
    {
        answer_val: 10.0,
    },
    {
        answer_val: 10.0,
    },
    {
        answer_val: 10.0,
    },
    {
        answer_val: 10.5,
    },
    {
        answer_val: 11.0,
    },
    {
        answer_val: 11.5,
    },
    {
        answer_val: 11.5,
    },
    {
        answer_val: 12.0,
    },
    {
        answer_val: 12.5,
    },
    {
        answer_val: 13.0,
    },
    {
        answer_val: 13.0,
    },
    {
        answer_val: 13.5,
}].each { |answer| answers << Answer.new(answer) }

fake_question = Question.new(id: 0)
fake_user = User.new(id: 0)
answers.each { |e|
    e.question = fake_question
    e.user = fake_user
}

begin
    answers.each(&:save!)
rescue => e
    puts '--->EXEPTION DURING SAVE<---'
    puts "Exeption type: #{e.class.name}"
    puts "Exeption message: #{e.message}"
    puts '~~~~~~~Stack trace~~~~~~~'
    e.backtrace.each { |line| puts line }
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
end
