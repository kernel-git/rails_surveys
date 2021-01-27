# frozen_string_literal: true

require 'rails_helper'

describe SurveyEmployeeConnection, 'validation' do
  subject do
    FactoryBot.create(:survey_employee_connection,
      survey_id: FactoryBot.create(:survey,
        employer_id: FactoryBot.create(:employer,
          account_id: FactoryBot.create(:account, account_type: 'employer').id
        ).id
      ).id,
      employee_id: FactoryBot.create(:employee,
        employer_id: FactoryBot.create(:employer,
          account_id: FactoryBot.create(:account, account_type: 'employer').id
        ).id,
        account_id: FactoryBot.create(:account, account_type: 'employee').id
      ).id
    )
  end

  context 'with valid attributes' do
    it { is_expected.to be_valid }
  end

  context 'without an attribute' do
    it { is_expected.to validate_presence_of(:employee_id) }
    it { is_expected.to validate_presence_of(:survey_id) }
  end
end

describe SurveyEmployeeConnection, 'association' do
  it { is_expected.to belong_to(:survey) }
  it { is_expected.to belong_to(:employee) }
end

describe SurveyEmployeeConnection, 'column_specification' do
  it { is_expected.to have_db_column(:is_conducted).of_type(:boolean) }

  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:employee_id).of_type(:integer) }
  it { is_expected.to have_db_column(:survey_id).of_type(:integer) }

  it { is_expected.to have_db_index(:employee_id) }
  it { is_expected.to have_db_index(:survey_id) }
end

describe SurveyEmployeeConnection, '.filter_conducted and .filter_avaible' do
  before(:each) do
    3.times do
      FactoryBot.create(:survey_employee_connection,
        survey_id: FactoryBot.create(:survey,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id
        ).id,
        employee_id: FactoryBot.create(:employee,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id,
          account_id: FactoryBot.create(:account, account_type: 'employee').id
        ).id,
        is_conducted: true
      )
    end
    5.times do
      FactoryBot.create(:survey_employee_connection,
        survey_id: FactoryBot.create(:survey,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id
        ).id,
        employee_id: FactoryBot.create(:employee,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id,
          account_id: FactoryBot.create(:account, account_type: 'employee').id
        ).id,
        is_conducted: false
      )
    end
  end

  it 'returns conducted survey employee connections' do
    expect(SurveyEmployeeConnection.filter_conducted.count).to eq 3
  end

  it 'returns not conducted survey employee connections' do
    expect(SurveyEmployeeConnection.filter_avaible.count).to eq 5
  end
end

describe SurveyEmployeeConnection, '.filter_by_survey_id' do
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
    4.times do
      FactoryBot.create(:survey_employee_connection,
        survey_id: survey1_id,
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
      FactoryBot.create(:survey_employee_connection,
        survey_id: survey2_id,
        employee_id: FactoryBot.create(:employee,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id,
          account_id: FactoryBot.create(:account, account_type: 'employee').id
        ).id,
        is_conducted: false
      )
    end
  end

  it 'returns survey employee connections for survey with survey_id' do
    expect(SurveyEmployeeConnection.filter_by_survey_id(survey1_id).count).to eq 4
    expect(SurveyEmployeeConnection.filter_by_survey_id(survey2_id).count).to eq 3
  end

  it 'returns empty when survey_id is blank' do
    expect(SurveyEmployeeConnection.filter_by_survey_id(nil).count).to eq 0
  end

  it 'returns empty when survey with survey_id is not found' do
    expect(SurveyEmployeeConnection.filter_by_survey_id(-1).count).to eq 0
  end
end

describe SurveyEmployeeConnection, '.filter_by_employee_id' do
  employee1_id = 0
  employee2_id = 0
  before(:each) do
    employee1_id = FactoryBot.create(:employee,
      employer_id: FactoryBot.create(:employer,
        account_id: FactoryBot.create(:account, account_type: 'employer').id
      ).id,
      account_id: FactoryBot.create(:account, account_type: 'employee').id
    ).id
    employee2_id = FactoryBot.create(:employee,
      employer_id: FactoryBot.create(:employer,
        account_id: FactoryBot.create(:account, account_type: 'employer').id
      ).id,
      account_id: FactoryBot.create(:account, account_type: 'employee').id
    ).id
    2.times do
      FactoryBot.create(:survey_employee_connection,
        survey_id: FactoryBot.create(:survey,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id
        ).id,
        employee_id: employee1_id,
        is_conducted: true
      )
    end
    5.times do
      FactoryBot.create(:survey_employee_connection,
        survey_id: FactoryBot.create(:survey,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id
        ).id,
        employee_id: employee2_id,
        is_conducted: false
      )
    end
  end

  it 'returns survey employee connections for employee with employee_id' do
    expect(SurveyEmployeeConnection.filter_by_employee_id(employee1_id).count).to eq 2
    expect(SurveyEmployeeConnection.filter_by_employee_id(employee2_id).count).to eq 5
  end

  it 'returns empty when employee_id is blank' do
    expect(SurveyEmployeeConnection.filter_by_employee_id(nil).count).to eq 0
  end

  it 'returns empty when survey with employee_id is not found' do
    expect(SurveyEmployeeConnection.filter_by_employee_id(-1).count).to eq 0
  end
end

describe SurveyEmployeeConnection, '.filter_by(_conducted)_employer_id' do
  employer1_id = 0
  employer2_id = 0
  before(:each) do
    employer1_id = FactoryBot.create(:employer,
                                     account_id: FactoryBot.create(:account, account_type: 'employer').id).id
    employer2_id = FactoryBot.create(:employer,
                                     account_id: FactoryBot.create(:account, account_type: 'employer').id).id
    2.times do
      FactoryBot.create(:survey_employee_connection,
        survey_id: FactoryBot.create(:survey,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id
        ).id,
        employee_id: FactoryBot.create(:employee,
          employer_id: employer1_id,
          account_id: FactoryBot.create(:account, account_type: 'employee').id
        ).id,
        is_conducted: true
      )
    end
    5.times do
      FactoryBot.create(:survey_employee_connection,
        survey_id: FactoryBot.create(:survey,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id
        ).id,
        employee_id: FactoryBot.create(:employee,
          employer_id: employer2_id,
          account_id: FactoryBot.create(:account, account_type: 'employee').id
        ).id,
        is_conducted: false
      )
    end
  end

  it 'returns (conducted)survey employee connections for employee\' employer with employer_id' do
    expect(SurveyEmployeeConnection.filter_by_employer_id(employer1_id).count).to eq 2
    expect(SurveyEmployeeConnection.filter_by_employer_id(employer2_id).count).to eq 5
    expect(SurveyEmployeeConnection.filter_conducted_by_employer_id(employer1_id).count).to eq 2
    expect(SurveyEmployeeConnection.filter_conducted_by_employer_id(employer2_id).count).to eq 0
  end

  it 'returns empty when employer_id is blank' do
    expect(SurveyEmployeeConnection.filter_by_employer_id(nil).count).to eq 0
    expect(SurveyEmployeeConnection.filter_conducted_by_employer_id(nil).count).to eq 0
  end

  it 'returns empty when employee with employer with employer_id is not found' do
    expect(SurveyEmployeeConnection.filter_by_employer_id(-1).count).to eq 0
    expect(SurveyEmployeeConnection.filter_conducted_by_employer_id(-1).count).to eq 0
  end
end
