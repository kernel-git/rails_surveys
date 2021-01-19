# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    account_type { %w[bronze silver gold].sample }
    age { Faker::Number.within(range: 1..100) }
    position_age { Faker::Number.digit }
    opt_out { [true, false].sample }

    account_id { '1' }
    employer_id { '1' }
  end
end
