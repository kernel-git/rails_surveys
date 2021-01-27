# frozen_string_literal: true

FactoryBot.define do
  factory :survey_employee_connection do
    is_conducted { [true, false].sample }

    employee_id { '1' }
    survey_id { '1' }
  end
end
