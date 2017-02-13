class CustomerOrderDelivery < ActiveRecord::Base
  class CancelService
    def initialize(customer_order_delivery)
      @customer_order_delivery = customer_order_delivery
    end

    def perform
      if can_cancel?
        @customer_order_delivery.update!(
          status: :canceled
        )
      end
    end

    private

    def can_cancel?
      responded_at = @customer_order_delivery.provider_responded_at
      responded_at.present? && inside_range?(responded_at)
    end

    def inside_range?(responded_at)
      (Time.now - responded_at) < 5.minutes
    end
  end
end
