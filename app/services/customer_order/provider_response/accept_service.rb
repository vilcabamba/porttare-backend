class CustomerOrder < ActiveRecord::Base
  module ProviderResponse
    class AcceptService < GenericResponseService
      ##
      # a provider will accept a customer order
      # he's been requested
      def initialize(provider, customer_order)
        @provider = provider
        @customer_order = customer_order
      end

      ##
      # @return Boolean
      def perform
        customer_order_delivery.transaction do
          mark_as_accepted!
          create_shipping_request_if_necessary!
        end
        true
      end

      private

      def mark_as_accepted!
        customer_order_delivery.update! status: :accepted
      end

      def create_shipping_request_if_necessary!
        if customer_order_delivery.delivery_method.shipping?
          ShippingRequest.create!(
            kind: :customer_order_delivery,
            resource: customer_order_delivery,
            address_attributes: customer_address_attributes
          )
        end
      end

      def customer_address_attributes
        customer_order_delivery.customer_address.attributes.slice(
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
