json.extract!(
  by_category[:provider_item_category],
  :id,
  :nombre
)

json.provider_items do
  json.array!(
    by_category[:provider_items],
    partial: "api/providers/items/provider_item",
    as: :provider_item
  )
end
