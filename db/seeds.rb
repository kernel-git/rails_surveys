# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

Answer.destroy_all
Client.destroy_all
QuestionGroup.destroy_all
Question.destroy_all
Segment.destroy_all
Survey.destroy_all
User.destroy_all

users = Array.new
[{
    first_name: 'Jonh',
    last_name: 'Smith',
    email: 'JohnSmith@gmail.com',
    password: '3dc0a15198cf0d9448ac35a8b863b3e2',
    account_type: 'administrator',
    age: 21,
    position_age: 1,
    opt_out: true
},
{
    first_name: 'Jane',
    last_name: 'Smith',
    email: 'JaneSmith@gmail.com',
    password: '1c0c5c33e69e3bfd37deaf439afc4248',
    account_type: 'administrator',
    age: 20,
    position_age: 3,
    opt_out: true
}].each { |hash| users << User.new(hash) }

clients = Array.new
[{
    label: 'client_one',
    email: 'JohnSmith@gmail.com',
    phone: '88005553535',
    address: 'Statue of Liberty, Liberty Island New York, NY 10004',
    logo_url: '¯\_(ツ)_/¯'
},
{
    label: 'client_two',
    email: 'JaneSmith@gmail.com',
    phone: '88005553535',
    address: 'Statue of Liberty, Liberty Island New York, NY 10004',
    logo_url: '¯\_(ツ)_/¯'
}].each { |hash| clients << Client.new(hash) }

segments = Array.new
[{
    label: 'segment_one'
},
{
    label: 'segment_two'
}].each { |hash| segments << Segment.new(hash) }

surveys = Array.new
[{
        label: 'survey_label_one'
    },
    {
        label: 'survey_label_two'
}].each { |hash| surveys << Survey.new(hash) }

question_groups = Array.new
[{
        label: 'question_group_one'
    },
    {
        label: 'question_group_two'
    },
    {
        label: 'question_group_three'
}].each { |hash| question_groups << QuestionGroup.new(hash) }

questions = Array.new
[{
        question_type: 'question_one',
        benchmark_val: 1,
        benchmark_vol: 1
    },
    {
        question_type: 'question_two',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'question_three',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'question_four',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'question_five',
        benchmark_val: 2,
        benchmark_vol: 2
    },
    {
        question_type: 'question_six',
        benchmark_val: 2,
        benchmark_vol: 2
}].each { |hash| questions << Question.new(hash) }

clients[0].user = users[0]
clients[1].user = users[1]

users[0].segments = segments
users[1].segments << segments[1]

clients[0].segments << segments[0]

surveys[0].clients << clients[0]
surveys[1].clients = clients

surveys[0].question_groups << question_groups[0]
surveys[0].question_groups << question_groups[1]
surveys[1].question_groups << question_groups[2]

question_groups[0].questions << questions[0]
question_groups[1].questions = questions[1, 2]
question_groups[2].questions = questions[3..5]

user1_answers = users[0].answers.build([{
        answer_val: 0.0,
    },
    {
        answer_val: 0.5,
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
}])
questions[0].answers << user1_answers[0]
user1_answers[1,2].each { |answ| questions[1].answers << answ }
user1_answers[3..5].each { |answ| questions[3].answers << answ }

user2_answers = users[1].answers.build([{
        answer_val: 3.0,
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
        answer_val: 5.0,
}])
user2_answers[0..3].each { |answ| questions[4].answers << answ }
questions[5].answers << user2_answers[4]

begin
    user1_answers.each(&:save!)
    user2_answers.each(&:save!)
    users.each(&:save!)
    clients.each(&:save!)
    segments.each(&:save!)
    surveys.each(&:save!)
    question_groups.each(&:save!)
    questions.each(&:save!)
rescue => e
    puts 'Save aborted due to the exception'
    puts "Exeption type: #{e.class.name}"
    puts "Exeption message: #{e.message}"
    puts "~~~~~~~Stack trace~~~~~~~"
    e.backtrace.each { |line| puts line }
end
