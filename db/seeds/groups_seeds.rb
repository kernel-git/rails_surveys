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
      rand(1..10).times { group.employees << Employee.find(Faker::Number.unique.within(range: 1..Employee.all.count)) }

      groups << group
    end

    begin
      groups.each(&:save!)
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      log_exception(e)
    end
  end
end
