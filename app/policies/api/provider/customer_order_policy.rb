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

      def show?
        is_provider? && provider_profile_in_record?
      end

      private

      def is_provider?
        user.provider_profile.present?
      end

      def provider_profile_in_record?
        record.provider_profile_ids.include?(
          user.provider_profile.id
        )
      end
    end
  end
end
