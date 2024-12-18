if @building.errors.present?
  json.message @building.errors.full_messages
else
  json.partial! "buildings/building", building: @building
end
