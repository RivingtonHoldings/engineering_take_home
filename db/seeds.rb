# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
client_1 = FactoryBot.create(:client)
client_2 = FactoryBot.create(:client)
client_3 = FactoryBot.create(:client)
client_4 = FactoryBot.create(:client)
client_5 = FactoryBot.create(:client)

FactoryBot.create(:enum_custom_field, client: client_1)
FactoryBot.create(:input_custom_field, input_type: :numeric, client: client_1)
FactoryBot.create(:input_custom_field, input_type: :freeform, client: client_1)

FactoryBot.create(:enum_custom_field, client: client_2)
FactoryBot.create(:input_custom_field, input_type: :numeric, client: client_2)
FactoryBot.create(:input_custom_field, input_type: :freeform, client: client_2)

FactoryBot.create(:enum_custom_field, client: client_3)
FactoryBot.create(:input_custom_field, input_type: :numeric, client: client_3)
FactoryBot.create(:input_custom_field, input_type: :freeform, client: client_3)

FactoryBot.create(:enum_custom_field, client: client_4)
FactoryBot.create(:input_custom_field, input_type: :numeric, client: client_4)
FactoryBot.create(:input_custom_field, input_type: :freeform, client: client_4)

FactoryBot.create(:enum_custom_field, client: client_5)
FactoryBot.create(:input_custom_field, input_type: :numeric, client: client_5)
FactoryBot.create(:input_custom_field, input_type: :freeform, client: client_5)

FactoryBot.create_list(:building, rand(1..5),
  custom_fields: CustomFieldsBuilder.new.call(
    schema: CustomFieldsSchemaBuilder.new.call(client_1.custom_fields),
    custom_fields: {}
  ).value!
)

FactoryBot.create_list(:building, rand(1..5),
  custom_fields: CustomFieldsBuilder.new.call(
    schema: CustomFieldsSchemaBuilder.new.call(client_2.custom_fields),
    custom_fields: {}
  ).value!
)

FactoryBot.create_list(:building, rand(1..5),
  custom_fields: CustomFieldsBuilder.new.call(
    schema: CustomFieldsSchemaBuilder.new.call(client_3.custom_fields),
    custom_fields: {}
  ).value!
)

FactoryBot.create_list(:building, rand(1..5),
  custom_fields: CustomFieldsBuilder.new.call(
    schema: CustomFieldsSchemaBuilder.new.call(client_4.custom_fields),
    custom_fields: {}
  ).value!
)

FactoryBot.create_list(:building, rand(1..5),
  custom_fields: CustomFieldsBuilder.new.call(
    schema: CustomFieldsSchemaBuilder.new.call(client_5.custom_fields),
    custom_fields: {}
  ).value!
)
