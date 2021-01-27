# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    label { Faker::Lorem.word }
  end
end
