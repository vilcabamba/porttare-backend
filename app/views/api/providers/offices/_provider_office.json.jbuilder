json.extract!(
  provider_office,
  :id,
  :direccion,
  :ciudad,
  :telefono
)
json.hora_de_apertura provider_office.hora_de_apertura.strftime("%H:%M %p")
json.hora_de_cierre provider_office.hora_de_cierre.strftime("%H:%M %p")
