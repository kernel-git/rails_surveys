require 'faker'

class SegmentsSeeds

  SEGMENTS = [
    'Teacher',
    'Technical',
    'Management',
    'Bachelor Student',
    'Master Student',
    'Ph D Student'
  ].freeze

  def initialize
  end

  def perform
    segments = Array.new

    6.times { |index| segments << Segment.new({ label: SEGMENTS[index] }) }

    6.times do |index|
      Faker::Number.unique.clear
      rand(1..4).times { segments[index].clients << Client.find_by(label: %w(BSUIR BSU BSTU BSAI BSMU).sample) }
      rand(1..3).times { segments[index].users << User.find(Faker::Number.unique.within(range: 1..8)) }
    end

    begin
      segments.each(&:save!)
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
