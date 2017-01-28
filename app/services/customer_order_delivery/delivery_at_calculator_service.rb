class CustomerOrderDelivery < ActiveRecord::Base
  class DeliveryAtCalculatorService
    def initialize(customer_order_delivery)
      @customer_order_delivery = customer_order_delivery
    end

    def delivery_at
      if calculate_eta?
        # TODO
        # consider provider's preparation time
        shipping_request.assigned_at + shipping_request.estimated_time_mins.minutes
      end
    end

    private

    def calculate_eta?
      shipping_request.present? &&
        shipping_request.estimated_time_mins.present?
    end

    def shipping_request
      @shipping_request ||= ShippingRequest.find_by(
        resource: @customer_order_delivery
      )
    end
  end
end
