FactoryBot.define do
  factory :survey_employee_relation do
    is_conducted { [true, false].sample }

    employee_id { '1' }
    survey_id { '1' }
  end
end
