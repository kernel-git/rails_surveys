# frozen_string_literal: true

require 'faker'

class SegmentsSeeds
  include LoggerExtension

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
      log_exception(e)
    end
  end
end
