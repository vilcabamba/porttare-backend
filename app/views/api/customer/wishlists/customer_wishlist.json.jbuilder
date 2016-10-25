json.customer_wishlist do
  json.extract!(
    @customer_wishlist,
    :id,
    :nombre,
    :provider_items_ids
  )
  json.entregar_en(
    l(@customer_wishlist.entregar_en, format: :api)
  )
end
