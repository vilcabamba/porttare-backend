module Api
  module Provider
    class ClientsController < BaseController
      resource_description do
        name "Provider::ClientsController"
        short "provider clients endpoint"
      end
      
      before_action :authenticate_api_auth_user!

      api :POST,
          "/provider/clients",
          "Create a provider client"
      param :notes, String
      param :ruc, String, required: true
      param :name, String, required: true
      param :address, String, required: true
      param :phone, String, required: true
      param :email, String, required: true
      def create
        authorize ProviderClient
        if create_item?
          render nothing: true, status: :created
        else
          @errors = @provider_client.errors
          render "api/shared/create_error",
                 status: :unprocessable_entity
        end
      end

      private

      def create_item?
        @provider_client =
          current_api_auth_user
            .provider_profile
            .provider_clients.new(provider_client_params)
        @provider_client.save
      end

      def provider_client_params
        params.permit(
          *policy(ProviderClient).permitted_attributes
        )
      end
    end
  end
end
