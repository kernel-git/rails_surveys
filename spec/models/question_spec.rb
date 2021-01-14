require 'rails_helper'

describe Question, 'validation' do
  subject do
    FactoryBot.create(:question,
                      question_group_id: FactoryBot.create(:question_group,
                                                           survey_id: FactoryBot.create(:survey,
                                                                                        employer_id: FactoryBot.create(:employer,
                                                                                                                       account_id: FactoryBot.create(:account, account_type: 'employer').id).id).id).id)
  end

  context 'with valid attributes' do
    it { is_expected.to be_valid }
  end

  context 'without an attribute' do
    it { is_expected.to validate_presence_of(:question_type) }
    it { is_expected.to validate_presence_of(:benchmark_val) }
    it { is_expected.to validate_presence_of(:benchmark_vol) }

    it { is_expected.to validate_presence_of(:question_group_id) }
  end
end

describe Question, 'association' do
  it { is_expected.to belong_to(:question_group) }
  it { is_expected.to have_many(:options) }
end

describe Question, 'column_specification' do
  it { is_expected.to have_db_column(:question_type).of_type(:string) }
  it { is_expected.to have_db_column(:benchmark_val).of_type(:integer) }
  it { is_expected.to have_db_column(:benchmark_vol).of_type(:integer) }

  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:question_group_id).of_type(:integer) }

  it { is_expected.to have_db_index(:question_group_id) }
end
