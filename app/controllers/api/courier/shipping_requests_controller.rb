module Api
  module Courier
    class ShippingRequestsController < BaseController
      resource_description do
        name "Courier::ShippingRequests"
        short "shipping requests available for couriers"
      end

      before_action :authenticate_api_auth_user!

      api :GET,
          "/courier/shipping_requests",
          "Shipping requests available for courier"
      description "`kind_text` is the localized value for `kind`"
      see "providers#index", "Categories::Providers#index for provider_profile serialization in response"
      example %q{{
  "shipping_requests":
    [{
      "id":1,
      "kind":"ask_to_validate",
      "kind_text":"Validar proveedor",
      "status":"new",
      "address_attributes": {"direccion":"Calle Miguel Ángel"},
      "provider_profile": {...}
    }]
}}
      def index
        authorize ShippingRequest
        @api_collection = resource_scope.latest
      end

      api :GET,
          "/courier/shipping_requests/:id",
          "Show a shipping request"
      see "courier-shipping_requests#index", "Courier::ShippingRequests#index for response serialization"
      param :id, Integer, required: true
      def show
        authorize ShippingRequest
        @api_resource = resource_scope.find params[:id]
      end

      private

      def resource_scope
        policy_scope(ShippingRequest)
      end
    end
  end
end
