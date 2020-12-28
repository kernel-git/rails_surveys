class AdminsSeeds

  def initialize
  end

  def perform
    admins = Array.new
    [{
      nickname: 'test_admin',
      email: 'test_admin@gmail.com',
      password: '11111111'
    }].each { |hash| admins << Administrator.new(hash) }

    begin
      admins.each(&:save!)
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
