# frozen_string_literal: true

FactoryBot.define do
  factory :question_group do
    label { Faker::Lorem.word }

    survey_id { '1' }
  end
end
