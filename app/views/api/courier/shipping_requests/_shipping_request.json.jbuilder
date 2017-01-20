json.extract!(
  shipping_request,
  :id,
  :kind,
  :kind_text,
  :status,
  :address_attributes,
  :waypoints
)

if shipping_request.kind.ask_to_validate?
  json.provider_profile do
    json.partial!(
      "api/providers/provider_profile",
      provider_profile: shipping_request.resource
    )
  end
end

if shipping_request.kind.customer_order_delivery?
  json.customer_order_delivery do
    json.partial!(
      "api/customer/customer_order_deliveries/customer_order_delivery",
      order_delivery: shipping_request.resource
    )
  end
end
