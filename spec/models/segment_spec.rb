# frozen_string_literal: true

require 'rails_helper'

describe Segment, 'validation' do
  subject do
    FactoryBot.create(:segment)
  end

  context 'with valid attributes' do
    it { is_expected.to be_valid }
  end

  context 'without an attribute' do
    it { is_expected.to validate_presence_of(:label) }
  end
end

describe Segment, 'association' do
  it { is_expected.to have_and_belong_to_many(:employees) }
  it { is_expected.to have_and_belong_to_many(:employers) }
end

describe Segment, 'column_specification' do
  it { is_expected.to have_db_column(:label).of_type(:string) }

  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
end
