json.provider_offices do
  json.array!(
    @provider_offices,
    partial: "api/provider/offices/full_provider_office",
    as: :provider_office
  )
end
