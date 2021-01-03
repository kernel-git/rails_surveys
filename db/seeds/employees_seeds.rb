require 'faker'

class EmployeesSeeds
  EMPLOYERS = [
    'BSUIR',
    'BSU',
    'BSTU',
    'BSMU',
    'BSAI'
  ].freeze

  def initialize
  end

  def perform
    employees = Array.new
    accounts = Array.new
    100.times do |index|
      account = Account.new({
        account_type: 'employee',
        email: Faker::Internet.unique.email,
        password: '11111111'
      })
      employee = Employee.new({
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        account_type: %w(bronze silver gold).sample,
        age: Faker::Number.within(range: 18..80),
        position_age: Faker::Number.within(range: 1..100),
        opt_out: true,
        employer_id: Employer.find_by(label: EMPLOYERS.sample).id
      })
      accounts << account
      employees << employee
    end

    begin
      100.times do |index|
        accounts[index].save!
        employees[index].account = accounts[index]
        employees[index].save!
      end
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
      puts '--->EXEPTION DURING Employee/Account SAVE<---'
      puts "Exeption type: #{e.class.name}"
      puts "Exeption message: #{e.message}"
      puts '~~~~~~~Stack trace~~~~~~~'
      e.backtrace.each { |line| puts line }
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
    end
  end
end