class CustomerOrderDeliveryDecorator < GenericResourceDecorator
  def card_attributes
    [
      :full_resume_for_card,
      :deliver_at
    ]
  end

  def full_resume_for_card
    "##{id} #{delivery_method_text} - #{status_text}"
  end

  def to_s
    full_resume_for_card
  end
end
