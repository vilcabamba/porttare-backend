json.extract!(
  category,
  :id,
  :titulo,
  :imagen,
  :descripcion
)

json.providers do
  json.array!(
    category.provider_profiles,
    partial: "provider_profile",
    as: :provider_profile
  )
end
