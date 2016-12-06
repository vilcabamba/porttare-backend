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

    json.deliver_at(
      l(@customer_order.deliver_at, format: :api)
    ) if @customer_order.deliver_at.present?

    json.provider_profiles do
      json.array!(
        @customer_order.provider_profiles,
        partial: "api/customer/cart/provider_profiles",
        as: :provider_profile
      )
    end
  else
    json.null!
  end
end
