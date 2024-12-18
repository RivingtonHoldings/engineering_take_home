json.(building, :id, :street_address_one, :street_address_two, :city, :state, :zipcode)
json.client_name building.client.name
json.merge! building.custom_fields.to_h
