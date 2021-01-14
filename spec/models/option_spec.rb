require 'rails_helper'

describe Option, 'validation' do
  subject do
    FactoryBot.create(:option,
                      question_id: FactoryBot.create(:question,
                                                     question_group_id: FactoryBot.create(:question_group,
                                                                                          survey_id: FactoryBot.create(:survey,
                                                                                                                       employer_id: FactoryBot.create(:employer,
                                                                                                                                                      account_id: FactoryBot.create(:account, account_type: 'employer').id).id).id).id).id)
  end

  context 'with valid attributes' do
    it { is_expected.to be_valid }
  end

  context 'without an attribute' do
    it { is_expected.to validate_presence_of(:text) }

    it { is_expected.to validate_presence_of(:question_id) }
  end
end

describe Option, 'association' do
  it { is_expected.to belong_to(:question) }
  it { is_expected.to have_many(:answers) }
end

describe Option, 'column_specification' do
  it { is_expected.to have_db_column(:text).of_type(:string) }

  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:question_id).of_type(:integer) }

  it { is_expected.to have_db_index(:question_id) }
end
