FactoryBot.define do
  factory :option do
    text { Faker::Lorem.sentence }
    has_text_field { [true, false].sample }

    question_id { '1' }
  end
end
