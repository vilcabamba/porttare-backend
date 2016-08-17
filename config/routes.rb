Rails.application.routes.draw do
  root to: redirect("/apipie")
  apipie
  namespace :api, defaults: { format: :json } do
    resources :locations, only: :create

    namespace :provider do
      resource :profile, only: :create # perhaps controller should be ProviderProfile
      resources :items, only: :create
    end

    namespace :auth do
      mount_devise_token_auth_for(
        "User",
        at: "user",
        controllers: {
          sessions: "api/auth/sessions",
          passwords: "api/auth/passwords",
          registrations: "api/auth/registrations",
          omniauth_callbacks: "api/auth/omniauth_callbacks"
          # token_validations: "api/token_validations"
        }
      )
    end
  end
end
