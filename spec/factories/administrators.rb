FactoryBot.define do
  factory :administrator do
    nickname { Faker::Internet.user_name }

    account_id { '1' }
  end
end
