require 'rails_helper'

RSpec.describe Employee, type: :model do
  it 'is valid with all valid attributes' do
    employer = Employer.new
    employers_employee = Employee.new(
      first_name: 'John',
      last_name: 'Shepard',
      email: 'ShepardCommander@gmail.com',
      password: '7af3bb483c70c2da63b34f4170a8d069',
      account_type: 'employee',
      age: 29,
      position_age: 1,
      opt_out: true
    )
    employers_employee.employer = employer
    expect(employers_employee).to be_valid
  end

  it 'is not valid without a first name' do
    employee = Employee.new(first_name: nil)
    employee.valid?
    expect(employee.errors[:first_name]).to include('can\'t be blank')
  end

  it 'is not valid without a last name' do
    employee = Employee.new(last_name: nil)
    employee.valid?
    expect(employee.errors[:last_name]).to include('can\'t be blank')
  end

  it 'is not valid without an email name' do
    employee = Employee.new(email: nil)
    employee.valid?
    expect(employee.errors[:email]).to include('can\'t be blank')
  end

  it 'is not valid without a password' do
    employee = Employee.new(password: nil)
    employee.valid?
    expect(employee.errors[:password]).to include('can\'t be blank')
  end

  it 'is not valid without an account type' do
    employee = Employee.new(account_type: nil)
    employee.valid?
    expect(employee.errors[:account_type]).to include('can\'t be blank')
  end

  it 'is not valid without an age' do
    employee = Employee.new(age: nil)
    employee.valid?
    expect(employee.errors[:age]).to include('can\'t be blank')
  end

  it 'is not valid without an postion age' do
    employee = Employee.new(position_age: nil)
    employee.valid?
    expect(employee.errors[:position_age]).to include('can\'t be blank')
  end

  it 'is not valid without an opt out' do
    employee = Employee.new(opt_out: nil)
    employee.valid?
    expect(employee.errors[:opt_out]).to include('can\'t be blank')
  end

  it 'is not valid with invalid email' do
    employee = Employee.new(email: 'ShepardCommandergmail.com')
    employee.valid?
    expect(employee.errors[:email]).to include('is not an email')
  end

  it 'is not valid with negative age' do
    employee = Employee.new(age: -5)
    employee.valid?
    expect(employee.errors[:age]).to include('must be greater than 0')
  end

  it 'is not valid with not integer age' do
    employee = Employee.new(age: 'hello')
    employee.valid?
    expect(employee.errors[:age]).to include('is not a number')
  end

  it 'is not valid without a employer' do
    employee = Employee.new
    employee.valid?
    expect(employee.errors[:employer]).to include('must exist')
  end
end
