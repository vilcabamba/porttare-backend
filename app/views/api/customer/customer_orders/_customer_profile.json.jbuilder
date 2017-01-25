# json.extract!(
#   customer_profile.user.decorate, # from user
#   :image_url,
#   :name,
#   :nickname,
#   :email,
#   :ciudad,
#   :current_place_id
# )

# we're only using a part of this
json.extract!(
  customer_profile.user,
  :name,
  :nickname
)
