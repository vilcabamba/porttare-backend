# full provider profile

json.extract!(
  provider_profile,
  :id,
  :telefono,
  :email,
  :nombre_establecimiento
)

json.offices do
  json.array!(
    provider_profile.offices,
    partial: "provider_office",
    as: :provider_office
  )
end
