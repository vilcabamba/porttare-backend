json.extract!(
  provider_office,
  :id,
  :direccion,
  :ciudad,
  :telefono
)

json.weekdays do
  json.array!(
    provider_office.weekdays.sorted,
    partial: "api/providers/offices/weekday",
    as: :provider_office_weekday
  )
end
