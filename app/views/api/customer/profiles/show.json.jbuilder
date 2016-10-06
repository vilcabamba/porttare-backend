json.customer_profile do
  json.partial!(
    "profile",
    customer_profile: @customer_profile
  )

  json.customer_addresses do
    json.array!(
      @customer_profile.customer_addresses,
      partial: "api/customer/addresses/address",
      as: :customer_address
    )
  end
end
