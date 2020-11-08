# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

Rake::Task['db:reset'].invoke

Dir[File.join(Rails.root, "db", "seeds", "*.rb")].sort.each do |seed|

    puts "seeding - #{seed}"
  
    load seed
end
  