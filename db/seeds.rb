[
  "Agua bidón/Gas",
  "Alimentos no preparados",
  "Alimentos preparados",
  "Bebidas alcohólicas",
  "Encomiendas",
  "Medicinas",
  "Panadería y pastelería",
  "Productos de floristería",
  "Reservas en restaurantes",
  "Tickets de shows"
].each do |category_name|
  ProviderCategory.where(
    titulo: category_name
  ).first_or_create
end
