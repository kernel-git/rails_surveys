# frozen_string_literal: true

require 'faker'

class GroupsSeeds
  include LoggerExtension

  GROUPS = [
    'Teacher',
    'Technical',
    'Management',
    'Bachelor Student',
    'Master Student',
    'Ph D Student'
  ].freeze

  def initialize; end

  def perform
    groups = []

    6.times do |index|
      group = Group.new({ label: GROUPS[index] })
      Faker::Number.unique.clear
      %w[BSUIR BSU BSTU BSAI BSMU].sample(rand(1..4)).each { |e| group.employers << Employer.find_by(label: e) }
      rand(1..3).times { group.employees << Employee.find(Faker::Number.unique.within(range: 1..8)) }

      groups << group
    end

    begin
      groups.each(&:save!)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      log_exception(e)
    end
  end
end
