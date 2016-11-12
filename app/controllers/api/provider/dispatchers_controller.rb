module Api
  module Provider
    class DispatchersController < Provider::BaseController
      include Api::BaseController::Resourceable
      include Api::Provider::BaseController::ResourceCollectionable

      resource_description do
        name "Provider::Dispatchers"
        short "provider's dispatchers"
      end

      self.resource_klass = ProviderDispatcher

      before_action :authenticate_api_auth_user!
      before_action :find_provider_office,
                    only: [:create, :update]

      api :GET,
          "/provider/dispatchers",
          "Lists provider's dispatchers"
      example %q{{
        "provider_dispatchers":[{
          "id":5,
          "email":"daron.gulgowski@ebertraynor.org",
          "provider_office_id":5,
          "user":{
            "id":7,
            "name":"Beatriz Soto Valles",
            "image":"https://robohash.org/architectoanimiquos.png?size=300x300&set=set1"
          }
        }]
      }}
      def index
        super
      end

      def_param_group :provider_dispatcher do
        param :email, String, required: true
        param :provider_office_id, Integer, required: true
      end

      api :POST,
          "/provider/dispatchers",
          "Create a provider dispatcher"
      param_group :provider_dispatcher
      def create
        super
      end

      api :PUT,
          "/provider/dispatchers/:id",
          "Update a provider's dispatcher"
      param :id,
            Integer,
            required: true,
            desc: "Provider dispatcher's id"
      param_group :provider_dispatcher
      def update
        super
      end

      api :DELETE,
          "/provider/dispatchers/:id",
          "Delete a provider's dispatcher"
      desc "a soft delete is performed"
      param :id,
            Integer,
            required: true,
            desc: "Provider dispatcher's id"
      def destroy
        super
      end

      private

      def resource_destruction_method
        :soft_destroy
      end

      def new_api_resource
        @api_resource = @provider_office.provider_dispatchers.new(resource_params)
      end

      def find_provider_office
        @provider_office = policy_scope(ProviderOffice).find(
          params[:provider_office_id]
        ) if params[:provider_office_id].present?
      rescue ActiveRecord::RecordNotFound
        # means provider office is not within
        # provider's scope
        raise Pundit::NotAuthorizedError
      end
    end
  end
end
