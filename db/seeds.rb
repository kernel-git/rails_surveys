# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

Rake::Task['db:reset'].invoke

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end
AdminsSeeds.new.perform
EmployersSeeds.new.perform
SurveysSeeds.new.perform
QuestionGroupsSeeds.new.perform
QuestionsSeeds.new.perform
EmployeesSeeds.new.perform
GroupsSeeds.new.perform
OptionsSeeds.new.perform
AnswersSeeds.new.perform
