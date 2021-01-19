# frozen_string_literal: true

require 'rails_helper'

describe Answer, 'validation' do
  subject do
    FactoryBot.create(:answer,
      employee_id: FactoryBot.create(:employee,
        employer_id: FactoryBot.create(:employer,
          account_id: FactoryBot.create(:account, account_type: 'employer').id
        ).id,
        account_id: FactoryBot.create(:account, account_type: 'employee').id
      .id,
      option_id: FactoryBot.create(:option,
        question_id: FactoryBot.create(:question,
          question_group_id: FactoryBot.create(:question_group,
            survey_id: FactoryBot.create(:survey,
              employer_id: FactoryBot.create(:employer,
                account_id: FactoryBot.create(:account, account_type: 'employer').id
              ).id
            ).id
          ).id
        ).id
      ).id
    )
  end

  context 'with valid attributes' do
    it { is_expected.to be_valid }
    it do
      subject.additional_text = nil
      is_expected.to be_valid
    end
  end

  context 'without an attribute' do
    it { is_expected.to validate_presence_of(:option_id) }
    it { is_expected.to validate_presence_of(:employee_id) }
  end
end

describe Answer, 'association' do
  it { is_expected.to belong_to(:option) }
  it { is_expected.to belong_to(:employee) }
end

describe Answer, 'column_specification' do
  it { is_expected.to have_db_column(:additional_text).of_type(:string) }
  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:option_id).of_type(:integer) }
  it { is_expected.to have_db_column(:employee_id).of_type(:integer) }

  it { is_expected.to have_db_index(:option_id) }
  it { is_expected.to have_db_index(:employee_id) }
end
