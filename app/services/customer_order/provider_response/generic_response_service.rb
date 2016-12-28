class CustomerOrder < ActiveRecord::Base
  module ProviderResponse
    class GenericResponseService
      protected

      def customer_order_delivery
        @customer_order_delivery ||= @customer_order.delivery_for_provider(
          @provider.provider_profile
        )
      end
    end
  end
end
