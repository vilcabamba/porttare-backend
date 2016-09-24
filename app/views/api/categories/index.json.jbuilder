json.provider_categories do
  json.array!(
    @categories,
    partial: "category",
    as: :category
  )
end
