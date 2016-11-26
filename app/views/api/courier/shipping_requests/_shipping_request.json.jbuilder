json.extract!(
  shipping_request,
  :id,
  :kind,
  :kind_text,
  :status,
  :address_attributes
)

json.provider_profile do
  json.partial!(
    "api/providers/provider_profile",
    provider_profile: shipping_request.provider_profile
  )
end
