# frozen_string_literal: true

FactoryBot.define do
  factory :segment do
    label { Faker::Lorem.word }
  end
end
