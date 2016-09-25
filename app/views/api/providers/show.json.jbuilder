json.provider_profile do
  ##
  # following partial is provider_profile's
  # public template
  json.partial!(
    "provider_profiles",
    provider_profile: @provider_profile
  )

  json.provider_items do
    json.array!(
      @provider_profile.provider_items,
      partial: "api/providers/items/provider_item",
      as: :provider_item
    )
  end
end
