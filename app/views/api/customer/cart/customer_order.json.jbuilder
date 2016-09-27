json.customer_order do
  json.extract!(
    @customer_order,
    :id,
    :status,
    :subtotal_items_cents
  )

  json.customer_order_items do
    json.array!(
      @customer_order.order_items,
      partial: "customer_order_item",
      as: :customer_order_item
    )
  end
end
