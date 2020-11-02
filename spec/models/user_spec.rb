require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with all valid attributes' do
    client = Client.new
    clients_user = User.new(
      first_name: 'John',
      last_name: 'Shepard',
      email: 'ShepardCommander@gmail.com',
      password: '7af3bb483c70c2da63b34f4170a8d069',
      account_type: 'employee',
      age: 29,
      position_age: 1,
      opt_out: true
    )
    clients_user.client = client
    expect(clients_user).to be_valid
  end
  it 'is not valid without a first name' do 
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include('can\'t be blank')
  end
  it 'is not valid without a last name' do 
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include('can\'t be blank')
  end
  it 'is not valid without an email name' do 
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include('can\'t be blank')
  end
  it 'is not valid without a password' do 
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include('can\'t be blank')
  end
  it 'is not valid without an account type' do 
    user = User.new(account_type: nil)
    user.valid?
    expect(user.errors[:account_type]).to include('can\'t be blank')
  end
  it 'is not valid without an age' do 
    user = User.new(age: nil)
    user.valid?
    expect(user.errors[:age]).to include('can\'t be blank')
  end
  it 'is not valid without an postion age' do 
    user = User.new(position_age: nil)
    user.valid?
    expect(user.errors[:position_age]).to include('can\'t be blank')
  end
  it 'is not valid without an opt out' do 
    user = User.new(opt_out: nil)
    user.valid?
    expect(user.errors[:opt_out]).to include('can\'t be blank')
  end
  it 'is not valid with invalid email' do
    user = User.new(email: 'ShepardCommandergmail.com')
    user.valid?
    expect(user.errors[:email]).to include('is not an email')
  end
  it 'is not valid with negative age' do
    user = User.new(age: -5)
    user.valid?
    expect(user.errors[:age]).to include('must be greater than 0')
  end
  it 'is not valid with not integer age' do
    user = User.new(age: 'hello')
    user.valid?
    expect(user.errors[:age]).to include('is not a number')
  end
  it 'is not valid without a client' do
    user = User.new
    user.valid?
    expect(user.errors[:client]).to include('must exist')
  end
end
