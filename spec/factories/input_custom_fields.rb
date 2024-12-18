FactoryBot.define do
  factory :input_custom_field do
    client
    name { Faker::Lorem.words(number: rand(1..4)).join("_") }
    input_type { [ "numeric", "freeform" ].sample }
  end
end
