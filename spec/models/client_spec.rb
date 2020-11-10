require 'rails_helper'

RSpec.describe Client, type: :model do
  it 'is valid with all valid attributes' do
    client = Client.new(
      label: 'client_label',
      email: 'ShepardCommander@gmail.com',
      phone: '88005553535',
      address: 'Something here',
      logo_url: 'nope'
    )
    expect(client).to be_valid
  end

  it 'is not valid without a label' do
    client = Client.new(label: nil)
    client.valid?
    expect(client.errors[:label]).to include('can\'t be blank')
  end

  it 'is not valid without an email' do
    client = Client.new(email: nil)
    client.valid?
    expect(client.errors[:email]).to include('can\'t be blank')
  end

  it 'is not valid without a phone' do
    client = Client.new(phone: nil)
    client.valid?
    expect(client.errors[:phone]).to include('can\'t be blank')
  end

  it 'is not valid without an address' do
    client = Client.new(address: nil)
    client.valid?
    expect(client.errors[:address]).to include('can\'t be blank')
  end

  it 'is not valid without a logo url' do
    client = Client.new(logo_url: nil)
    client.valid?
    expect(client.errors[:logo_url]).to include('can\'t be blank')
  end

  it 'is not valid with invalid email' do
    client = Client.new(email: 'ShepardCommandergmail.com')
    client.valid?
    expect(client.errors[:email]).to include('is not an email')
  end
end
