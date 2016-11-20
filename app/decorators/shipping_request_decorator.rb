class ShippingRequestDecorator < GenericResourceDecorator
  delegate_all

  def card_attributes
    [
      :kind
    ]
  end
end
