require 'faker'

class UsersSeeds
  CLIENTS = [
    'BSUIR',
    'BSUIR',
    'BSUIR',
    'BSU',
    'BSTU',
    'BSTU',
    'BSMU',
    'BSAI'
  ].freeze

  def initialize
  end

  def perform
    users = Array.new
    8.times do |index|
      users << User.new({
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: '3dc0a15198cf0d9448ac35a8b863b3e2',
        account_type: %w(bronze silver gold).sample,
        age: Faker::Number.within(range: 18..80),
        position_age: Faker::Number.within(range: 1..100),
        opt_out: true,
        client_id: Client.find_by(label: CLIENTS[index]).id
      })
    end

    begin
      users.each(&:save!)
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