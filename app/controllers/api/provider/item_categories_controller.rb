module Api
  module Provider
    class ItemCategoriesController < Provider::BaseController
      include Api::BaseController::Scopable
      include Api::Provider::BaseController::ResourceCollectionable

      resource_description do
        name "Provider::ItemCategories"
        short "provider item categories"
      end

      before_action :authenticate_api_auth_user!

      self.resource_klass = ProviderItemCategory

      api :GET,
          "/provider/item_categories",
          "Lists categories available for a provider"
      desc "`personal` means this category is available only for this provider. `predeterminada` is the default category used for provider items"
      example %q{{
  "provider_item_categories":[
    {
      "id":1,
      "nombre":"Games \u0026 Baby",
      "personal":false,
      "predeterminada":true
    },
    {
      "id":2,
      "nombre":"Clothing",
      "personal":true,
      "predeterminada":false
    }
  ]
}}
      def index
        super
      end
    end
  end
end
