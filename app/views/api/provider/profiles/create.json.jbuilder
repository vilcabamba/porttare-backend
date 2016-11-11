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
      partial: "api/provider/offices/full_provider_office",
      as: :provider_office
    )
  end
end
