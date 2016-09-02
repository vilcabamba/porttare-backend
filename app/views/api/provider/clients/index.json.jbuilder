json.provider_clients do
  json.array!(
    @provider_clients,
    partial: "client",
    as: :provider_client
  )
end
