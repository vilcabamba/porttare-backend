json.provider_profile do
  json.partial!(
    "api/providers/provider_profile",
    provider_profile: @provider_profile
  )
  json.partial!(
    "api/providers/private_provider_profile",
    provider_profile: @provider_profile
  )

  json.provider_offices do
    json.array!(
      @provider_profile.offices,
      partial: "provider_offices",
      as: :provider_office
    )
  end
end
