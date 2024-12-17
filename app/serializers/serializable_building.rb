class SerializableBuilding < JSONAPI::Serializable::Resource
  type "building"

  attributes :street_address_one, :street_address_two

  t.string :street_address_one, null: false
  t.string :street_address_two
  t.string :city, null: false
  t.string :state, null: false
  t.string :zipcode, null: false


  attribute :date do
    @object.created_at
  end
end
