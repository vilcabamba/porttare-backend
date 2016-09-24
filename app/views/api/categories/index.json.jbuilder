json.provider_categories do
  json.array!(
    @provider_categories,
    partial: "provider_category",
    as: :provider_category
  )
end
