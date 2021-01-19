# frozen_string_literal: true

require 'rails_helper'

describe Survey, 'validation' do
  subject do
    FactoryBot.create(:survey,
      employer_id: FactoryBot.create(:employer,
        account_id: FactoryBot.create(:account, account_type: 'employer')
      .id)
    .id)
  end

  context 'with valid attributes' do
    it { is_expected.to be_valid }
  end

  context 'without an attribute' do
    it { is_expected.to validate_presence_of(:label) }

    it { is_expected.to validate_presence_of(:employer_id) }
  end
end

describe Survey, 'association' do
  it { is_expected.to belong_to(:employer) }
  it { is_expected.to have_many(:question_groups) }
  it { is_expected.to have_many(:survey_employee_relations) }
  it { is_expected.to have_many(:employees).through(:survey_employee_relations) }
end

describe Survey, 'column_specification' do
  it { is_expected.to have_db_column(:label).of_type(:string) }

  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:employer_id).of_type(:integer) }

  it { is_expected.to have_db_index(:employer_id) }
end

describe Survey, '.filter_by_employer_id' do
  employer1_id = 0
  employer2_id = 0

  before(:each) do
    employer1 = FactoryBot.create(:employer,
                                  account_id: FactoryBot.create(:account, account_type: 'employer').id)
    employer1_id = employer1.id
    employer2 = FactoryBot.create(:employer,
                                  account_id: FactoryBot.create(:account, account_type: 'employer').id)
    employer2_id = employer2.id
    3.times do
      FactoryBot.create(:survey, employer_id: employer1_id)
    end
    2.times do
      FactoryBot.create(:survey, employer_id: employer2_id)
    end
  end

  it 'returns surveys for employer with employer_id' do
    expect(Survey.filter_by_employer_id(employer1_id).count).to eq 3
    expect(Survey.filter_by_employer_id(employer2_id).count).to eq 2
  end

  it 'returns empty when employer_id is blank' do
    expect(Survey.filter_by_employer_id(nil).count).to eq 0
  end

  it 'returns empty when employer with employer_id is not found' do
    expect(Survey.filter_by_employer_id(-1).count).to eq 0
  end
end

describe Survey, '.filter_avaible_by_assigned_employee_id' do
  employee1_id = 0
  employee2_id = 0

  before(:each) do
    employee1 = FactoryBot.create(:employee,
      employer_id: FactoryBot.create(:employer,
        account_id: FactoryBot.create(:account, account_type: 'employer').id
      ).id,
      account_id: FactoryBot.create(:account, account_type: 'employee').id
    )
    employee1_id = employee1.id
    employee2 = FactoryBot.create(:employee,
      employer_id: FactoryBot.create(:employer,
        account_id: FactoryBot.create(:account, account_type: 'employer').id
      ).id,
      account_id: FactoryBot.create(:account, account_type: 'employee').id
    )
    employee2_id = employee2.id

    3.times do
      FactoryBot.create(:survey_employee_relation,
        survey_id: FactoryBot.create(:survey,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id
        ).id,
        employee_id: employee1_id,
        is_conducted: false
      )
    end
    4.times do
      FactoryBot.create(:survey_employee_relation,
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

  it 'returns not conducted surveys for employee with employee_id' do
    expect(Survey.filter_avaible_by_assigned_employee_id(employee1_id).count).to eq 3
    expect(Survey.filter_avaible_by_assigned_employee_id(employee2_id).count).to eq 4
  end

  it 'returns empty when employee_id is blank' do
    expect(Survey.filter_avaible_by_assigned_employee_id(nil).count).to eq 0
  end

  it 'returns empty when employee with employee_id is not found' do
    expect(Survey.filter_avaible_by_assigned_employee_id(-1).count).to eq 0
  end
end

describe Survey, '.filter_conducted_by_assigned_employee_id' do
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

    4.times do
      FactoryBot.create(:survey_employee_relation,
        survey_id: FactoryBot.create(:survey,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id
        ).id,
        employee_id: employee1_id,
        is_conducted: true
      )
    end
    2.times do
      FactoryBot.create(:survey_employee_relation,
        survey_id: FactoryBot.create(:survey,
          employer_id: FactoryBot.create(:employer,
            account_id: FactoryBot.create(:account, account_type: 'employer').id
          ).id
        ).id,
        employee_id: employee2_id,
        is_conducted: true
      )
    end
  end

  it 'returns conducted surveys for employee with employee_id' do
    expect(Survey.filter_conducted_by_assigned_employee_id(employee1_id).count).to eq 4
    expect(Survey.filter_conducted_by_assigned_employee_id(employee2_id).count).to eq 2
  end

  it 'returns empty when employee_id is blank' do
    expect(Survey.filter_conducted_by_assigned_employee_id(nil).count).to eq 0
  end

  it 'returns empty when employee with employee_id is not found' do
    expect(Survey.filter_conducted_by_assigned_employee_id(-1).count).to eq 0
  end
end
