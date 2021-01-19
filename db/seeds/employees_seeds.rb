# frozen_string_literal: true

require 'faker'

class EmployeesSeeds
  EMPLOYERS = %w[
    BSUIR
    BSU
    BSTU
    BSMU
    BSAI
  ].freeze

  def initialize; end

  def perform
    employees = []
    accounts = []
    100.times do |_index|
      account = Account.new({
                              account_type: 'employee',
                              email: Faker::Internet.unique.email,
                              password: '11111111'
                            })
      employee = Employee.new({
                                first_name: Faker::Name.first_name,
                                last_name: Faker::Name.last_name,
                                account_type: %w[bronze silver gold].sample,
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
      log_exception(e)
    end
  end
end
