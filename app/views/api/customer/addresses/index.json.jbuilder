json.customer_addresses do
  json.array!(
    @customer_addresses,
    partial: "address",
    as: :customer_address
  )
end
