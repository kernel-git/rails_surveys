require 'faker'

class AnswersSeeds
  def initialize
  end

  def perform
    Question.all.each do |question|
      Faker::Number.unique.clear
      rand(0..8).times do
        begin
          Answer.create!({
              answer_val: rand(27).to_f / 2,
              question_id: question.id,
              user_id: Faker::Number.unique.within(range: 1..8)
          })
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
  end
end