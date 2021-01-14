require 'rails_helper'

describe Employer, 'validation' do
  subject do
    FactoryBot.create(:employer,
                      account_id: FactoryBot.create(:account, account_type: 'employer').id)
  end

  context 'with valid attributes' do
    it { is_expected.to be_valid }
  end

  context 'without an attribute' do
    it { is_expected.to validate_presence_of(:label) }
    it { is_expected.to validate_presence_of(:public_email) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:logo_url) }

    it { is_expected.to validate_presence_of(:account_id) }
  end

  it 'is not valid with invalid email' do
    subject.public_email = 'invalid one'
    subject.valid?
    expect(subject.errors[:public_email]).to include('is not an email')
  end
end

describe Employer, 'association' do
  it { is_expected.to belong_to(:account) }
  it { is_expected.to have_many(:employees) }
  it { is_expected.to have_many(:surveys) }
  it { is_expected.to have_and_belong_to_many(:segments) }
end

describe Employer, 'column_specification' do
  it { is_expected.to have_db_column(:label).of_type(:string) }
  it { is_expected.to have_db_column(:phone).of_type(:string) }
  it { is_expected.to have_db_column(:address).of_type(:text) }
  it { is_expected.to have_db_column(:logo_url).of_type(:string).with_options(default: '', null: false) }
  it { is_expected.to have_db_column(:public_email).of_type(:string) }

  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:account_id).of_type(:integer) }

  it { is_expected.to have_db_index(:account_id) }
end
