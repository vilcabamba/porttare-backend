# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
           Rails.application.secrets.facebook_key,
           Rails.application.secrets.facebook_secret,
           scope: "public_profile,email,user_birthday"
end
