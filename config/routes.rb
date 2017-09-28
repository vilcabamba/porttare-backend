Rails.application.routes.draw do
  root to: redirect("/apipie")
  apipie

  namespace :api, defaults: { format: :json } do
    resources :locations, only: :create
    resources :products, only: :index
    resource :pusher_auth, only: :create
    resource :tos, only: :show
    resources :categories, only: :index do
      resources :providers, only: [:index, :show] do
        resources :items, only: :show
      end
    end

    namespace :customer do
      namespace :cart do
        root to: 'items#index'
        resources :items,
                  only: [:create, :update, :destroy]
        resource :checkout,
                 only: :create
        resources :deliveries,
                  only: [:update]
      end
      resource :service_providers, only: [:show]
      resources :wishlists,
                only: [:index, :create, :update, :destroy]
      resources :addresses,
                only: [:index, :show, :create, :update]
      resources :billing_addresses,
                only: [:index, :show, :create, :update]
      resources :orders,
                only: [:index, :show] do
        resources :deliveries, only: [] do
          member do
            post :cancel
          end
        end
      end
    end

    namespace :provider do
      resource :profile,
               only: [:create, :update]
      resources :items,
                only: [:index, :show, :create, :update, :destroy]
      resources :offices,
                only: [:index, :show, :create, :update]#, :destroy]
      resources :clients,
                only: [:index, :create, :update, :destroy]
      resources :dispatchers,
                only: [:index, :show, :create, :update, :destroy]
      resources :item_categories,
                only: [:index]
      resources :customer_orders,
                only: [:index, :show] do
        member do
          post :accept
          post :reject
        end
      end
    end

    namespace :courier do
      resource :profile, only: :create
      resources :shipping_requests,
                only: [:index, :show] do
        member do
          post :take
          post :in_store
          post :delivered
        end
      end
    end

    namespace :users do
      resource :tos,
               only: :create
      resource :account,
               only: [:show, :update]
      resources :places,
                only: :index
      resources :devices,
                only: :create
    end

    namespace :auth do
      resource :native_login, only: :create
      mount_devise_token_auth_for(
        "User",
        at: "user",
        controllers: {
          sessions: "api/auth/sessions",
          passwords: "api/auth/passwords",
          registrations: "api/auth/registrations",
          token_validations: "api/auth/token_validations",
          omniauth_callbacks: "api/auth/omniauth_callbacks"
        }
      )
    end
  end

  devise_for :admins,
             path: "admin",
             class_name: "User",
             skip: [
               :registrations,
               :passwords
             ]
  namespace :admin do
    resources :resource_version, only: :show
    resources :shipping_requests
    resources :provider_item_categories
    resources :provider_items
    resources :customer_orders
    resources :places do
      resources :shipping_fares
      resource :shipping_costs do
        collection do
          post :calculate
        end
      end
    end
    resources :users do
      collection do
        get "/by_status/:status",
            to: "users#index",
            as: :by_status
      end
    end
    resources :provider_profiles do
      collection do
        get "/by_status/:status",
            to: "provider_profiles#index",
            as: :by_status
      end
      member do
        post "/transition/:predicate",
             to: "provider_profiles#transition",
             as: :transition
      end
    end
    resources :provider_categories do
      collection do
        get "/by_status/:status",
            to: "provider_categories#index",
            as: :by_status
      end
    end
    root "provider_profiles#index"
  end
end
