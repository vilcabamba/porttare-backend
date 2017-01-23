class ShippingRequest < ActiveRecord::Base
  class TakeService
    def initialize(options)
      @courier_profile = options.fetch(:courier_profile)
      @shipping_request = options.fetch(:shipping_request)
      @estimated_time_mins = options.fetch(:estimated_time_mins)
    end

    def perform!
      @shipping_request.transaction do
        @shipping_request.paper_trail_event = :take_by_courier
        assign_attributes
        @shipping_request.status = :assigned
        @shipping_request.save!
      end
    end

    private

    def assign_attributes
      @shipping_request.assign_attributes(
        courier_profile: @courier_profile,
        estimated_time_mins: @estimated_time_mins
      )
    end
  end
end
