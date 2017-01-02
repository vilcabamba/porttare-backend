class CustomerOrder < ActiveRecord::Base
  module ProviderResponse
    class GenericResponseService
      protected

      def customer_order_delivery
        @customer_order_delivery ||= @customer_order.delivery_for_provider(
          @provider.provider_profile
        )
      end

      def notify_pusher!
        channel_name = "private-customer_order.#{@customer_order.id}"
        Pusher.trigger(channel_name, "update", pusher_json)
      end

      def pusher_json
        view = ApplicationController.view_context_class.new(
          "#{Rails.root}/app/views/"
        )
        resource_json = JbuilderTemplate.new(view).encode do |json|
          json.partial! 'api/customer/customer_orders/customer_order', customer_order: @customer_order
        end
        { customer_order: resource_json }
      end
    end
  end
end
