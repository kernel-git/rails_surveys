# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    question_type { Faker::Lorem.question }
    benchmark_val { Faker::Number.digit }
    benchmark_vol { Faker::Number.digit }

    question_group_id { '1' }
  end
end
