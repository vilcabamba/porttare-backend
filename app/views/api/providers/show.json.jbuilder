json.provider_profile do
  ##
  # following partial is provider_profile's
  # public template
  json.partial!(
    "provider_profiles",
    provider_profile: @provider_profile
  )

  json.provider_item_categories do
    json.array!(
      @provider_profile.provider_items_by_categories,
      partial: "api/providers/item_categories/provider_item_category",
      as: :by_category
    )
  end
end
