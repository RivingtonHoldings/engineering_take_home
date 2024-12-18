json.buildings do
  json.array! @buildings, partial: "buildings/building", as: :building
  if @page.present? && @number_per_page.present?
    json.page @page
    json.number_per_page @number_per_page
  end
end
