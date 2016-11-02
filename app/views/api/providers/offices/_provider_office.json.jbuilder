json.extract!(
  provider_office,
  :id,
  :direccion,
  :ciudad,
  :telefono
)
# TODO define this format as standard
json.hora_de_apertura provider_office.hora_de_apertura.in_time_zone.strftime("%H:%M %p")
json.hora_de_cierre provider_office.hora_de_cierre.in_time_zone.strftime("%H:%M %p")
