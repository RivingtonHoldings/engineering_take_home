json.buildings do
  json.array! @buildings, partial: "building/building", as: :building
  json.page @page
  json.number_per_page @number_per_page
end
