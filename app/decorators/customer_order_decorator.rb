class CustomerOrderDecorator < GenericResourceDecorator
  decorates_association :customer_profile
  decorates_association :deliveries

  def to_s
    h.t("activerecord.models.customer_order") + " ##{id}"
  end

  def card_attributes
    [
      :submitted_at,
      :customer_profile
    ]
  end

  def detail_attributes
    card_attributes
  end

  def link_to_resource(options=nil, &block)
    h.link_to(
      h.admin_customer_order_path(object),
      options,
      &block
    )
  end
end
