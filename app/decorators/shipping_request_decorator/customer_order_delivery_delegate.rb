class ShippingRequestDecorator < GenericResourceDecorator
  class CustomerOrderDeliveryDelegate < ::Draper::Decorator
    delegate_all

    def address
      address_attributes["direccion_uno"] if address_attributes.present?
    end

    def telefono
      address_attributes["numero_convencional"] if address_attributes.present?
    end

    def customer_order_delivery
      resource.str_with_link
    end

    def card_attributes
      [
        :created_at,
        :address,
        :customer_order_delivery,
        :telefono
      ]
    end
  end
end
