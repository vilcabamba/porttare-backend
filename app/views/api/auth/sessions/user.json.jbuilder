if @success.present?
  json.success @success
end

json.data do
  json.partial!("user", user: @resource)

  ##
  # bearer token protocol
  json.client_id @client_id
  json.auth_token @token
  json.expiry @expiry
end
