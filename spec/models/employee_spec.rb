# frozen_string_literal: true

require 'rails_helper'

describe Employee, 'validation' do
  subject do
    FactoryBot.create(:employee,
      employer_id: FactoryBot.create(:employer,
        account_id: FactoryBot.create(:account, account_type: 'employer').id
      ).id,
      account_id: FactoryBot.create(:account, account_type: 'employee').id
    )
  end

  context 'with valid attributes' do
    it { is_expected.to be_valid }
  end

  context 'without an attribute' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:account_type) }
    it { is_expected.to validate_presence_of(:age) }
    it { is_expected.to validate_presence_of(:position_age) }

    it { is_expected.to validate_presence_of(:employer_id) }
    it { is_expected.to validate_presence_of(:account_id) }
  end

  context 'with invalid attribute' do
    it { is_expected.to validate_numericality_of(:age) }
  end
end

describe Employee, 'association' do
  it { is_expected.to belong_to(:employer) }
  it { is_expected.to belong_to(:account) }
  it { is_expected.to have_many(:survey_employee_relations) }
  it { is_expected.to have_many(:surveys).through(:survey_employee_relations) }
  it { is_expected.to have_many(:answers) }
  it { is_expected.to have_and_belong_to_many(:segments) }
end

describe Employee, 'column_specification' do
  it { is_expected.to have_db_column(:first_name).of_type(:string) }
  it { is_expected.to have_db_column(:last_name).of_type(:string) }
  it { is_expected.to have_db_column(:account_type).of_type(:string) }
  it { is_expected.to have_db_column(:age).of_type(:integer) }
  it { is_expected.to have_db_column(:position_age).of_type(:integer) }

  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:employer_id).of_type(:integer) }
  it { is_expected.to have_db_column(:account_id).of_type(:integer) }

  it { is_expected.to have_db_index(:employer_id) }
  it { is_expected.to have_db_index(:account_id) }
end

describe Employee, '.filter_by_employer_id' do
  employer1_id = 0
  employer2_id = 0

  before(:each) do
    employer1 = FactoryBot.create(:employer,
      account_id: FactoryBot.create(:account, account_type: 'employer').id)
    employer2 = FactoryBot.create(:employer,
      account_id: FactoryBot.create(:account, account_type: 'employer').id)
    3.times do
      FactoryBot.create(:employee,
        employer_id: employer1.id,
        account_id: FactoryBot.create(:account, account_type: 'employee').id)
    end
    2.times do
      FactoryBot.create(:employee,
        employer_id: employer2.id,
        account_id: FactoryBot.create(:account, account_type: 'employee').id)
    end
    employer1_id = employer1.id
    employer2_id = employer2.id
  end

  it 'returns employees that match with employer_id' do
    expect(Employee.filter_by_employer_id(employer1_id).count).to eq 3
    expect(Employee.filter_by_employer_id(employer2_id).count).to eq 2
  end

  it 'returns empty when employer_id is blank' do
    expect(Employee.filter_by_employer_id(nil).count).to eq 0
  end

  it 'returns empty when employer_id is not match' do
    expect(Employee.filter_by_employer_id(-1).count).to eq 0
  end
end

describe Employee, '.filter_avaible_by_survey_id' do
  survey1_id = 0
  survey2_id = 0

  before(:each) do
    survey1_id = FactoryBot.create(:survey,
      employer_id: FactoryBot.create(:employer,
        account_id: FactoryBot.create(:account, account_type: 'employer').id
      ).id
    ).id
    survey2_id = FactoryBot.create(:survey,
      employer_id: FactoryBot.create(:employer,
        account_id: FactoryBot.create(:account, account_type: 'employer').id
      ).id
    ).id

    2.times do
      FactoryBot.create(:survey_employee_relation,
        survey_id: survey1_id,
        employee_id: FactoryBot.create(:employee,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id,
          account_id: FactoryBot.create(:account, account_type: 'employee').id
        ).id,
        is_conducted: false
      )
    end
    5.times do
      FactoryBot.create(:survey_employee_relation,
        survey_id: survey2_id,
        employee_id: FactoryBot.create(:employee,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id,
          account_id: FactoryBot.create(:account, account_type: 'employee').id
        ).id,
        is_conducted: false)
    end

    survey1_id = survey1.id
    survey2_id = survey2.id
  end

  it 'returns not conducted employees for survey with survey_id' do
    expect(Employee.filter_avaible_by_survey_id(survey1_id).count).to eq 2
    expect(Employee.filter_avaible_by_survey_id(survey2_id).count).to eq 5
  end

  it 'returns empty when survey is blank' do
    expect(Employee.filter_avaible_by_survey_id(nil).count).to eq 0
  end

  it 'returns empty when survey with survey_id is not found' do
    expect(Employee.filter_by_employer_id(-1).count).to eq 0
  end
end

describe Employee, '.filter_conducted_by_survey_id' do
  survey1_id = 0
  survey2_id = 0

  before(:each) do
    survey1 = FactoryBot.create(:survey,
      employer_id: FactoryBot.create(:employer,
        account_id: FactoryBot.create(:account, account_type: 'employer').id
      ).id
    )
    survey2 = FactoryBot.create(:survey,
      employer_id: FactoryBot.create(:employer,
        account_id: FactoryBot.create(:account, account_type: 'employer').id
      ).id
    )

    6.times do
      FactoryBot.create(:survey_employee_relation,
        survey_id: survey1.id,
        employee_id: FactoryBot.create(:employee,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id,
          account_id: FactoryBot.create(:account, account_type: 'employee').id
        ).id,
        is_conducted: true
      )
    end
    3.times do
      FactoryBot.create(:survey_employee_relation,
        survey_id: survey2.id,
        employee_id: FactoryBot.create(:employee,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id,
          account_id: FactoryBot.create(:account, account_type: 'employee').id
        ).id,
        is_conducted: true
      )
    end

    survey1_id = survey1.id
    survey2_id = survey2.id
  end

  it 'returns conducted employees for survey with survey_id' do
    expect(Employee.filter_conducted_by_survey_id(survey1_id).count).to eq 6
    expect(Employee.filter_conducted_by_survey_id(survey2_id).count).to eq 3
  end

  it 'returns empty when survey is blank' do
    expect(Employee.filter_conducted_by_survey_id(nil).count).to eq 0
  end

  it 'returns empty when survey with survey_id is not found' do
    expect(Employee.filter_conducted_by_survey_id(-1).count).to eq 0
  end
end
