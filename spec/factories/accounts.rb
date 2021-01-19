# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    password { '11111111' }
    account_type { 'employee' }
  end
end
