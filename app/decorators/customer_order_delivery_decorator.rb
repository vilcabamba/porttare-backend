class CustomerOrderDeliveryDecorator < GenericResourceDecorator
  def card_attributes
    [
      :full_resume_for_card
    ]
  end

  def full_resume_for_card
    "##{id} #{delivery_method_text} - #{status_text}"
  end
end
