json.extract!(
  customer_order,
  :id,
  :status,
  :observaciones,
  :forma_de_pago,
  :anon_billing_address,
  :subtotal_items_cents,
  :customer_billing_address_id
)

json.submitted_at(
  l(customer_order.submitted_at, format: :api)
) if customer_order.submitted_at.present?

json.customer_billing_address do
  json.partial!(
    "api/customer/billing_addresses/billing_address",
    billing_address: customer_order.customer_billing_address
  )
end if customer_order.status.submitted? && customer_order.customer_billing_address.present?
