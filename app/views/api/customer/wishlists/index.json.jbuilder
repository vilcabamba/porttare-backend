json.customer_wishlists do
  json.array!(
    @customer_wishlists,
    partial: "customer_wishlist",
    as: :customer_wishlist
  )
end
