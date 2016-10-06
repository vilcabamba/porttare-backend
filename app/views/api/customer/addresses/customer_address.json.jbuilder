json.customer_address do
  json.partial!(
    "address",
    customer_address: @customer_address
  )
end
