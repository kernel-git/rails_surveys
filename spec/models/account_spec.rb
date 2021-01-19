# frozen_string_literal: true

require 'rails_helper'

describe Account, 'validation' do
  subject { FactoryBot.create(:account) }

  context 'with valid attributes' do
    it { is_expected.to be_valid }
  end

  context 'without an attribute' do
    it { is_expected.to validate_presence_of(:email) }
  end

  it 'is not valid with invalid email' do
    subject.email = 'invalid one'
    subject.valid?
    expect(subject.errors[:email]).to include('is invalid')
  end
end

describe Account, 'association' do
  it { is_expected.to have_one(:administrator) }
  it { is_expected.to have_one(:employer) }
  it { is_expected.to have_one(:employee) }
end

describe Account, 'column_specification' do
  it { is_expected.to have_db_column(:email).of_type(:string).with_options(default: '', null: false) }
  it { is_expected.to have_db_column(:encrypted_password).of_type(:string).with_options(default: '', null: false) }
  it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
  it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:failed_attempts).of_type(:integer).with_options(default: 0, null: false) }
  it { is_expected.to have_db_column(:unlock_token).of_type(:string) }
  it { is_expected.to have_db_column(:locked_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:account_type).of_type(:string).with_options(default: 'employee', null: false) }

  it { is_expected.to have_db_index(:email).unique(true) }
  it { is_expected.to have_db_index(:reset_password_token).unique(true) }
  it { is_expected.to have_db_index(:unlock_token).unique(true) }
end
