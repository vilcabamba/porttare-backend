class CustomerOrder < ActiveRecord::Base
  module ProviderResponse
    class RejectService < GenericResponseService
      ##
      # a provider may reject a customer order
      # providing a reason
      def initialize(provider, customer_order, rejection_params)
        @provider = provider
        @customer_order = customer_order
        @rejection_params = rejection_params
      end

      ##
      # @return Boolean
      def perform
        return unless valid?
        in_transaction do
          mark_as_rejected!
          notify_pusher!
        end
        true
      end

      def valid?
        @rejection_params[:reason].present?
      end

      private

      def paper_trail_event
        :provider_reject_delivery
      end

      def mark_as_rejected!
        customer_order_delivery.update!(
          status: :rejected,
          reason: @rejection_params[:reason]
        )
      end
    end
  end
end
