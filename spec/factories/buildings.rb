FactoryBot.define do
  factory :building do
    client
    street_address_one { Faker::Address.street_address }
    street_address_two { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zipcode { Faker::Address.zip_code }
  end
end
