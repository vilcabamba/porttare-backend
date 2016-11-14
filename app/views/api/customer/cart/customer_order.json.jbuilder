json.customer_order do
  if @customer_order.present?
    json.extract!(
      @customer_order,
      :id,
      :status,
      :observaciones,
      :forma_de_pago,
      :delivery_method,
      :subtotal_items_cents,
      :customer_address_id,
      :customer_billing_address_id
    )

    json.customer_order_items do
      json.array!(
        @customer_order.order_items,
        partial: "api/customer/cart/customer_order_item",
        as: :customer_order_item
      )
    end
  else
    json.null!
  end
end
