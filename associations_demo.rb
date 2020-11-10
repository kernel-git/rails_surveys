def print_object_info(object)
  puts "#{object.class.name} Model"
  object.class.column_names.each { |e| puts "#{e.capitalize}: #{object.send(e)}" }
  puts '~~~~~~~~~~~~~~'
end

Client.all.each do |client|
  puts '----> Client Info'
  print_object_info(client)
  puts 'Client\'s surveys info'
  client.surveys.each { |survey| print_object_info(survey) }
  puts 'Empty' if client.surveys.empty?

  puts 'Client\'s segments info'
  client.segments.each { |segment| print_object_info(segment) }
  puts 'Empty' if client.segments.empty?
end

Segment.all.each do |segment|
  puts '----> Segment Info'
  print_object_info(segment)
  puts 'Segment\'s users info'
  segment.users.each { |user| print_object_info(user) }
  puts 'Empty' if segment.users.empty?

  puts 'Segment\'s clients info'
  segment.clients.each { |client| print_object_info(client) }
  puts 'Empty' if segment.clients.empty?
end

random_survey = Survey.all[rand(Survey.all.length)]
puts '----> Survey Info'
print_object_info(random_survey)
puts 'Survey\'s question groups info'
random_survey.question_groups.each do |question_group|
  print_object_info(question_group)
  puts 'Question group\'s questions info'
  question_group.questions.each { |question| print_object_info(question) }
  puts 'Empty' if question_group.questions.empty?
end
puts 'Empty' if random_survey.question_groups.empty?
