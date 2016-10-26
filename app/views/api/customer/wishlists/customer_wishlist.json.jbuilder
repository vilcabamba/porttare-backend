json.customer_wishlist do
  json.partial!(
    "customer_wishlist",
    customer_wishlist: @customer_wishlist
  )
end
