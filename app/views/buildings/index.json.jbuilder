json.buildings do
  json.array! @buildings, partial: "buildings/building", as: :building
end
if @page.present? && @per_page.present?
  json.page @page.to_i
  json.per_page @per_page.to_i
end
