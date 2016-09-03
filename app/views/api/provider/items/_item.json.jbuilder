json.extract!(
  provider_item,
  :id,
  :titulo,
  :descripcion,
  :unidad_medida,
  :precio_cents,
  :volumen,
  :peso,
  :observaciones,
  :created_at,
  :updated_at
)

json.imagenes do
  json.array!(
    provider_item.imagenes,
    partial: "item_imagen",
    as: :provider_item_image
  )
end
