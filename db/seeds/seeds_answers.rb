answers = Array.new

43.times do
    answers << Answer.new({ answer_val: rand(27).to_f / 2 })
end

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
