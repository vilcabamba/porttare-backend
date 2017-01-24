class ShippingRequestDecorator < GenericResourceDecorator
  class AskToValidateDelegate < ::Draper::Decorator
    delegate_all

    def address
      address_attributes["direccion"] if address_attributes.present?
    end

    def telefono
      address_attributes["telefono"] if address_attributes.present?
    end

    def provider
      resource.str_with_link
    end

    def card_attributes
      [
        :created_at,
        :address,
        :provider,
        :telefono
      ]
    end

    def detail_attributes
      card_attributes + [
        :reason
      ]
    end
  end
end
