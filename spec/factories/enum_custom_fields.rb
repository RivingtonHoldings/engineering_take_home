FactoryBot.define do
  factory :enum_custom_field do
    client
    name { Faker::Lorem.words(number: rand(1..4)).join("_") }
    values { Faker::Lorem.words(number: rand(1..4)) }
  end
end
