class CustomerOrderDecorator < GenericResourceDecorator
  decorates_association :customer_profile

  def to_s
    h.t("activerecord.models.customer_order") + " ##{id}"
  end

  def card_attributes
    [
      :submitted_at,
      :customer_profile
    ]
  end
end
