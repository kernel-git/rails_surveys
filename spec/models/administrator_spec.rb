# frozen_string_literal: true

require 'rails_helper'

describe Administrator, 'validation' do
  subject do
    FactoryBot.create(:administrator, account_id:
      FactoryBot.create(:account, account_type: 'administrator').id)
  end

  context 'with valid attributes' do
    it { is_expected.to be_valid }
  end

  context 'without an attribute' do
    it { is_expected.to validate_presence_of(:nickname) }
    it { is_expected.to validate_presence_of(:account_id) }
  end
end

describe Administrator, 'association' do
  it { is_expected.to belong_to(:account) }
end

describe Administrator, 'column_specification' do
  it { is_expected.to have_db_column(:nickname).of_type(:string) }
  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:account_id).of_type(:integer) }

  it { is_expected.to have_db_index(:account_id) }
end
