json.category do
  # this template will call our local
  # _provider_profile partial
  # (api/providers/provider_profile)
  # which has complete information for
  # the provider profile
  json.partial! "api/categories/category",
                category: @category
end
