json.partial!(
  "provider_profile",
  provider_profile: provider_profile
)

# only enabled offices
json.provider_offices do
  json.array!(
    provider_profile.offices.enabled,
    partial: "api/providers/offices/provider_office",
    as: :provider_office
  )
end
