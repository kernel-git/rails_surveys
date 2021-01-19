# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    additional_text { Faker::Lorem.sentence }

    employee_id { '1' }
    option_id { '1' }
  end
end
