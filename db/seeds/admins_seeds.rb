class AdminsSeeds

  def initialize
  end

  def perform
    admin = Administrator.new({
      nickname: 'test_admin'
    })
    account = Account.new({
      account_type: 'administrator',
      email: 'test_admin@gmail.com',
      password: '11111111'
    })

    begin
      account.save!
      admin.account = account
      admin.save!
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      puts '--->EXEPTION DURING Admin/Account SAVE<---'
      puts "Exeption type: #{e.class.name}"
      puts "Exeption message: #{e.message}"
      puts '~~~~~~~Stack trace~~~~~~~'
      e.backtrace.each { |line| puts line }
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
    end

  end
end
