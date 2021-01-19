# frozen_string_literal: true

require 'rails_helper'

describe QuestionGroup, 'validation' do
  subject do
    FactoryBot.create(:question_group,
      survey_id: FactoryBot.create(:survey,
        employer_id: FactoryBot.create(:employer,
          account_id: FactoryBot.create(:account, account_type: 'employer').id
        ).id
      ).id
    )
  end

  context 'with valid attributes' do
    it { is_expected.to be_valid }
  end

  context 'without an attribute' do
    it { is_expected.to validate_presence_of(:label) }

    it { is_expected.to validate_presence_of(:survey_id) }
  end
end

describe QuestionGroup, 'association' do
  it { is_expected.to belong_to(:survey) }
  it { is_expected.to have_many(:questions) }
end

describe QuestionGroup, 'column_specification' do
  it { is_expected.to have_db_column(:label).of_type(:string) }

  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:survey_id).of_type(:integer) }

  it { is_expected.to have_db_index(:survey_id) }
end
