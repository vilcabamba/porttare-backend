module Api
  module Provider
    class DispatchersController < BaseController
      include Api::BaseController::Resourceable

      resource_description do
        name "Provider::Dispatchers"
        short "provider's dispatchers"
      end

      self.resource_klass = ProviderDispatcher

      before_action :authenticate_api_auth_user!
      before_action :pundit_authorize,
                    only: [:index, :create]
      before_action :find_provider_office,
                    only: [:create, :update]
      before_action :find_provider_dispatcher,
                    only: [:update, :destroy]

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
        @provider_dispatchers = provider_scope
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
        authorize @provider_dispatcher
        if @provider_dispatcher.update_attributes(provider_dispatcher_params)
          render :dispatcher, status: :accepted
        else
          @errors = @provider_dispatcher.errors
          render "api/shared/resource_error",
                 status: :unprocessable_entity
        end
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
        authorize @provider_dispatcher
        @provider_dispatcher.soft_destroy
        head :no_content
      end

      private

      def new_api_resource
        @api_resource = @provider_office.provider_dispatchers.new(resource_params)
      end

      def find_provider_dispatcher
        @provider_dispatcher = provider_scope.find(params[:id])
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
