# frozen_string_literal: true

require 'faker'

class EmployeesSeeds
  include LoggerExtension

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
    100.times do |_index|
      employee = Employee.new({
                                first_name: Faker::Name.first_name,
                                last_name: Faker::Name.last_name,
                                account_type: %w[bronze silver gold].sample,
                                age: Faker::Number.within(range: 18..80),
                                position_age: Faker::Number.within(range: 1..100),
                                opt_out: true,
                                employer_id: Employer.find_by(label: EMPLOYERS.sample).id
                              })
      employee.build_account(
        account_user_type: 'Employee',
        email: Faker::Internet.unique.email,
        password: '11111111',
        password_confirmation: '11111111'
      )
      employees << employee
    end

    100.times do |index|
      log_errors(employees[index]) unless employees[index].save
    end
  end
end
