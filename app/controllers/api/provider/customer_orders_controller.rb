module Api
  module Provider
    class CustomerOrdersController < Provider::BaseController
      include Api::BaseController::Scopable
      include Api::Provider::BaseController::ResourceCollectionable

      resource_description do
        name "Provider::CustomerOrders"
        short "provider's customer orders"
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

      private

      def resource_scope
        skip_policy_scope
        Api::Provider::CustomerOrderPolicy::Scope.new(
          pundit_user,
          resource_klass
        ).resolve
      end

      def pundit_authorize
        skip_authorization
        policy = Api::Provider::CustomerOrderPolicy.new(
          pundit_user,
          resource_klass
        )
        raise Pundit::NotAuthorizedError unless policy.send("#{action_name}?")
      end

      def current_provider_profile
        pundit_user.provider_profile
      end
      helper_method :current_provider_profile
    end
  end
end
