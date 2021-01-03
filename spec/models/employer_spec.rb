require 'rails_helper'

RSpec.describe Employer, type: :model do
  it 'is valid with all valid attributes' do
    employer = Employer.new(
      label: 'employer_label',
      email: 'ShepardCommander@gmail.com',
      phone: '88005553535',
      address: 'Something here',
      logo_url: 'nope'
    )
    expect(employer).to be_valid
  end

  it 'is not valid without a label' do
    employer = Employer.new(label: nil)
    employer.valid?
    expect(employer.errors[:label]).to include('can\'t be blank')
  end

  it 'is not valid without an email' do
    employer = Employer.new(email: nil)
    employer.valid?
    expect(employer.errors[:email]).to include('can\'t be blank')
  end

  it 'is not valid without a phone' do
    employer = Employer.new(phone: nil)
    employer.valid?
    expect(employer.errors[:phone]).to include('can\'t be blank')
  end

  it 'is not valid without an address' do
    employer = Employer.new(address: nil)
    employer.valid?
    expect(employer.errors[:address]).to include('can\'t be blank')
  end

  it 'is not valid without a logo url' do
    employer = Employer.new(logo_url: nil)
    employer.valid?
    expect(employer.errors[:logo_url]).to include('can\'t be blank')
  end

  it 'is not valid with invalid email' do
    employer = Employer.new(email: 'ShepardCommandergmail.com')
    employer.valid?
    expect(employer.errors[:email]).to include('is not an email')
  end
end
