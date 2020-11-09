require 'faker'

users = Array.new
8.times do
    users << User.new({
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: '3dc0a15198cf0d9448ac35a8b863b3e2',
        account_type: %w(bronze silver gold).sample,
        age: Faker::Number.within(range: 18..80),
        position_age: Faker::Number.within(range: 1..100),
        opt_out: true
    })
end

users[0..2].each { |e| e.client = Client.find_by(label: 'BSUIR') }
users[3].client = Client.find_by(label: 'BSU')
users[4, 5].each { |e| e.client = Client.find_by(label: 'BSTU') }
users[6].client = Client.find_by(label: 'BSMU')
users[7].client = Client.find_by(label: 'BSAI')

users[0].segments << Segment.find_by(label: 'Teacher')
users[0].segments << Segment.find_by(label: 'Management')

users[1].segments << Segment.find_by(label: 'Bachelor Student')

users[2].segments << Segment.find_by(label: 'Technical')
users[2].segments << Segment.find_by(label: 'Management')

users[3].segments << Segment.find_by(label: 'Technical')
users[3].segments << Segment.find_by(label: 'Ph D Student')

users[4].segments << Segment.find_by(label: 'Master Student')

users[5].segments << Segment.find_by(label: 'Teacher')
users[5].segments << Segment.find_by(label: 'Master Student')

users[6].segments << Segment.find_by(label: 'Technical')

users[7].segments << Segment.find_by(label: 'Teacher')
users[7].segments << Segment.find_by(label: 'Technical')
users[7].segments << Segment.find_by(label: 'Management')

begin
    users.each(&:save!)
rescue => e
    puts '--->EXEPTION DURING SAVE<---'
    puts "Exeption type: #{e.class.name}"
    puts "Exeption message: #{e.message}"
    puts '~~~~~~~Stack trace~~~~~~~'
    e.backtrace.each { |line| puts line }
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
end

Question.all.each do |question|
    Faker::Number.unique.clear
    rand(0..8).times do
        begin
            Answer.create!({
                answer_val: rand(27).to_f / 2,
                question_id: question.id,
                user_id: Faker::Number.unique.within(range: 1..8)
            })
        rescue => e
            puts '--->EXEPTION DURING SAVE<---'
            puts "Exeption type: #{e.class.name}"
            puts "Exeption message: #{e.message}"
            puts '~~~~~~~Stack trace~~~~~~~'
            e.backtrace.each { |line| puts line }
            puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
        end
    end
end
