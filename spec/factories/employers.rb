# frozen_string_literal: true

FactoryBot.define do
  factory :employer do
    label { Faker::Company.name }
    phone { Faker::PhoneNumber.phone_number }
    address { Faker::Address.full_address }
    logo_url { Faker::Company.logo }
    public_email { Faker::Internet.safe_email }

    account_id { '1' }
  end
end
