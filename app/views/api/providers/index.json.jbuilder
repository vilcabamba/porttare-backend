json.category do
  json.extract!(
    @category,
    :id,
    :titulo,
    :imagen,
    :descripcion
  )
end

json.providers do
  json.array!(
    @category.provider_profiles,
    partial: "provider",
    as: :provider
  )
end
