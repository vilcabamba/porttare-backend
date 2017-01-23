class ShippingRequest < ActiveRecord::Base
  class InStoreService
    def initialize(options)
      @courier_profile = options.fetch(:courier_profile)
      @shipping_request = options.fetch(:shipping_request)
    end

    def perform!
      in_transaction do
        # TODO notify or something
      end
    end

    protected

    def in_transaction(&block)
      @shipping_request.transaction do
        @shipping_request.paper_trail_event = paper_trail_event
        yield if block_given?
        @shipping_request.status = resource_status
        @shipping_request.save!
      end
    end

    private

    def paper_trail_event
      :courier_in_store
    end

    def resource_status
      :in_progress
    end
  end
end
