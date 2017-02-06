class CustomerOrder < ActiveRecord::Base
  module ProviderResponse
    ##
    # a provider will accept a customer order
    # he's been requested providing an estimated
    # time for preparation
    class AcceptService < GenericResponseService
      ##
      # @return Boolean
      def perform
        return unless valid?
        in_transaction do
          mark_as_accepted!
          create_shipping_request_if_necessary!
          notify_pusher!
        end
        true
      end

      def valid?
        @request_params[:preparation_time_mins].present?
      end

      private

      def paper_trail_event
        :provider_accept_delivery
      end

      def mark_as_accepted!
        customer_order_delivery.update!(
          status: :accepted,
          preparation_time_mins: @request_params[:preparation_time_mins],
          provider_responded_at: Time.now
        )
      end

      def create_shipping_request_if_necessary!
        if customer_order_delivery.delivery_method.shipping?
          ShippingRequest.create!(
            place: @customer_order.place,
            kind: :customer_order_delivery,
            resource: customer_order_delivery,
            waypoints: [ provider_office_waypoint ],
            address_attributes: customer_address_attributes
          )
        end
      end

      def provider_office_waypoint
        customer_order_delivery
          .closest_provider_office
          .attributes
          .slice("lat", "lon")
      end

      def customer_address_attributes
        customer_order_delivery
          .customer_address
          .attributes
          .slice(
            "lat",
            "lon",
            "ciudad",
            "barrio",
            "nombre",
            "parroquia",
            "referencia",
            "direccion_uno",
            "direccion_dos",
            "codigo_postal",
            "numero_convencional"
          )
      end
    end
  end
end
