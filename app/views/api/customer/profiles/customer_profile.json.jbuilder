json.customer_profile do
  json.partial!(
    "profile",
    customer_profile: @user.customer_profile
  )
end
