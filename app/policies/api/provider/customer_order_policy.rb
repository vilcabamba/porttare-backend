module Api
  module Provider
    class CustomerOrderPolicy < ::ApplicationPolicy
      class Scope < Scope
        def resolve
          deliveries = CustomerOrderDelivery.where(
            provider_profile_id: user.provider_profile.id
          )
          scope.where(
            id: deliveries.pluck(:customer_order_id)
          )
        end
      end

      def index?
        is_provider?
      end

      private

      def is_provider?
        user.provider_profile.present?
      end
    end
  end
end
