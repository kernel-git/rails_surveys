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

users[0].answers << Answer.find(1)
users[0].answers << Answer.find(7)
users[0].answers << Answer.find(3)
users[0].answers << Answer.find(9)
users[0].answers << Answer.find(15)

users[1].answers << Answer.find(2)
users[1].answers << Answer.find(4)
users[1].answers << Answer.find(8)
users[1].answers << Answer.find(38)
users[1].answers << Answer.find(43)
users[1].answers << Answer.find(34)

users[2].answers << Answer.find(5)
users[2].answers << Answer.find(16)
users[2].answers << Answer.find(18)
users[2].answers << Answer.find(20)
users[2].answers << Answer.find(22)
users[2].answers << Answer.find(26)
users[2].answers << Answer.find(35)

users[3].answers << Answer.find(6)
users[3].answers << Answer.find(10)
users[3].answers << Answer.find(17)
users[3].answers << Answer.find(19)
users[3].answers << Answer.find(21)
users[3].answers << Answer.find(23)
users[3].answers << Answer.find(27)

users[4].answers << Answer.find(11)
users[4].answers << Answer.find(24)
users[4].answers << Answer.find(28)

users[5].answers << Answer.find(12)
users[5].answers << Answer.find(25)
users[5].answers << Answer.find(29)
users[5].answers << Answer.find(31)

users[6].answers << Answer.find(13)
users[6].answers << Answer.find(30)
users[6].answers << Answer.find(32)
users[6].answers << Answer.find(36)
users[6].answers << Answer.find(39)
users[6].answers << Answer.find(41)

users[7].answers << Answer.find(14)
users[7].answers << Answer.find(33)
users[7].answers << Answer.find(37)
users[7].answers << Answer.find(40)
users[7].answers << Answer.find(42)

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
