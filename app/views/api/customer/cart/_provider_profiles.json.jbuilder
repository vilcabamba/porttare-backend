json.partial!(
  "api/providers/provider_profile",
  provider_profile: provider_profile
)

json.customer_order_items do
  json.array!(
    @customer_order.order_items_by_provider(provider_profile),
    partial: "api/customer/cart/customer_order_item",
    as: :customer_order_item
  )
end
