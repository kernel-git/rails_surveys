# frozen_string_literal: true

FactoryBot.define do
  factory :survey do
    label { Faker::Lorem.word }

    employer_id { '1' }
  end
end
