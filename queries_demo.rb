puts 'Task #1'
puts 'Looking for survey in which participate most users'
# long SQL query which finds survey in which participate most users
# SELECT id, label, created_at, updated_at, MAX(participants_count) AS participants_count
# FROM(
# SELECT s.*, COUNT(DISTINCT u.id) AS participants_count
# FROM surveys AS s, question_groups AS qg, questions AS q, answers AS a, users AS u
# WHERE qg.survey_id = s.id AND q.question_group_id = qg.id AND a.question_id = q.id AND a.user_id = u.id
# GROUP BY s.id
# );

result = Survey.joins(question_groups: [{questions: :answers}]).group(:id).distinct.count(:user_id).max_by { |k, v| v }

result_survey = Survey.find(result[0])
puts "Result survey(id: #{result_survey.id}, label: #{result_survey.label})"
puts "with total users count: #{result[1]}"

puts 'Task #2'
# long SQL query which gets the most popular among users answer
# SELECT a.answer_val, COUNT(DISTINCT u.id) 
# FROM users AS u, answers AS a
# WHERE u.id = a.user_id
# GROUP BY answer_val; 

(1..Client.count).each do |client_id|
    client = Client.where(id: client_id).includes(segments: :users)
    puts "Proccessing client with id: #{client[0].id}, label: #{client[0].label}"
    puts '~~~~~~~~~~~~~~~~~~~'
    puts '~~~~~~~~~~~~~~~~~~~'

    client[0].segments.each do |s| 
        puts "Proccessing segment with id: #{s.id}, label: #{s.label}"

        user_ids = Array.new
        s.users.each { |u| user_ids << u.id }
        puts "Found user ids: #{user_ids}"
        
        answ_data = User.where(id: user_ids).joins(:answers).group(:answer_val).distinct.count(:user_id).max_by { |k, v| v}
        result_question = Question.find(Answer.find_by(answer_val: answ_data[0]).question_id)
        puts "Result question(id: #{result_question.id}, question_type: #{result_question.question_type})"
        puts "with amount of equal answers: #{answ_data[1]}"
        puts '~~~~~~~~~~~~~~~~~~~'
    end
end