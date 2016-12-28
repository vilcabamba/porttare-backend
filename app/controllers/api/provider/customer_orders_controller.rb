module Api
  module Provider
    class CustomerOrdersController < Provider::BaseController
      include Api::BaseController::Scopable
      include Api::BaseController::Resourceable
      include Api::Provider::BaseController::ResourceCollectionable

      resource_description do
        name "Provider::CustomerOrders"
        short "provider's customer orders"
        description "customer orders will contain only current provider's profile"
      end

      self.resource_klass = CustomerOrder

      before_action :authenticate_api_auth_user!

      api :GET,
          "/provider/customer_orders",
          "List provider's customer orders"
      see "customer-orders#index", "Customer::Orders#index for customer order serialization in response"
      def index
        super
      end

      api :GET,
          "/provider/customer_orders/:id",
          "Show a provider's customer order"
      see "customer-orders#index", "Customer::Orders#index for customer order serialization in response"
      def show
        super
      end

      private

      def resource_scope
        skip_policy_scope
        Api::Provider::CustomerOrderPolicy::Scope.new(
          pundit_user,
          resource_klass
        ).resolve
      end

      def pundit_authorize
        if provider_policy(resource_klass).send("#{action_name}?")
          skip_authorization
        else
          raise Pundit::NotAuthorizedError
        end
      end

      def pundit_authorize_resource
        if provider_policy(@api_resource).send("#{action_name}?")
          skip_authorization
        else
          raise Pundit::NotAuthorizedError
        end
      end

      def provider_policy(subject)
        Api::Provider::CustomerOrderPolicy.new pundit_user, subject
      end

      def current_provider_profile
        pundit_user.provider_profile
      end
      helper_method :current_provider_profile
    end
  end
end
