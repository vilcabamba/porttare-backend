json.extract!(
  order_delivery,
  :id,
  :status,
  :reason,
  :delivery_method,
  :customer_address_attributes,
  :shipping_fare_price_cents,
  :delivery_at
)

json.deliver_at(
  l(order_delivery.deliver_at, format: :api)
) if order_delivery.deliver_at.present?

json.customer_address_id(
  order_delivery.customer_address_or_default.try :id
)
