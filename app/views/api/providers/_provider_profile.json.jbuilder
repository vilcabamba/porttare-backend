json.extract!(
  provider_profile,
  :id,
  :nombre_establecimiento
)

json.offices do
  json.array!(
    provider_profile.offices,
    partial: "provider_office",
    as: :provider_office
  )
end
