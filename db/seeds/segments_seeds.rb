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

  def initialize; end

  def perform
    segments = []

    6.times do |index|
      segment = Segment.new({ label: SEGMENTS[index] })
      Faker::Number.unique.clear
      %w[BSUIR BSU BSTU BSAI BSMU].sample(rand(1..4)).each { |e| segment.employers << Employer.find_by(label: e) }
      rand(1..3).times { segment.employees << Employee.find(Faker::Number.unique.within(range: 1..8)) }

      segments << segment
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
