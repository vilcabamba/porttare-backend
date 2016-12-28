json.extract!(
  order_delivery,
  :id,
  :status,
  :reason,
  :delivery_method,
  :customer_address_id,
)

json.deliver_at(
  l(order_delivery.deliver_at, format: :api)
) if order_delivery.deliver_at.present?
