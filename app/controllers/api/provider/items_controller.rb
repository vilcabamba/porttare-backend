module Api
  module Provider
    class ItemsController < BaseController
      resource_description do
        name "Provider::ItemsController"
        short "provider items endpoint"
      end

      api :POST,
          "/provider/items",
          "Create a provider item"
      param :titulo, String, required: true
      param :descripcion, String
      param :precio, Float, required: true
      param :volumen, String
      param :peso, String
      param :imagen, File
      param :observaciones, String
      param :unidad_medida,
            String,
            "one of the following: #{ProviderItem::UNIDADES_MEDIDA.join(", ")}"
      def create
        authorize ProviderItem
        if create_item?
          render nothing: true, status: :created
        else
          @errors = @provider_item.errors
          render "api/shared/create_error",
                 status: :unprocessable_entity
        end
      end

      private

      def create_item?
        @provider_item =
          current_api_auth_user
            .provider_profile
            .provider_items.new(provider_item_params)
        @provider_item.save
      end

      def provider_item_params
        params.permit(
          *policy(ProviderItem).permitted_attributes
        )
      end
    end
  end
end
