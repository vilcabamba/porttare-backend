json.extract!(
  place,
  :id,
  :lat,
  :lon,
  :nombre,
  :country,
  :flag_image_url
)

json.full_str place.to_s
