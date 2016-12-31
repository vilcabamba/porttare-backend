json.extract!(
  customer_order,
  :id,
  :status,
  :observaciones,
  :forma_de_pago,
  :subtotal_items_cents,
  :customer_billing_address_id
)

json.submitted_at(
  l(customer_order.submitted_at, format: :api)
) if customer_order.submitted_at.present?
