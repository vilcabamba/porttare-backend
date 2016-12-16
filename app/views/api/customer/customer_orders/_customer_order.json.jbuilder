json.extract!(
  customer_order,
  :id,
  :status,
  :observaciones,
  :forma_de_pago,
  :delivery_method,
  :subtotal_items_cents,
  :customer_address_id,
  :customer_billing_address_id
)

json.deliver_at(
  l(customer_order.deliver_at, format: :api)
) if customer_order.deliver_at.present?


json.provider_profiles do
  json.array! customer_order.provider_profiles do |provider_profile|
    json.partial!(
      "api/customer/cart/provider_profiles",
      provider_profile: provider_profile,
      customer_order: customer_order
    )
  end
end
