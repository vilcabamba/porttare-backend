class ShippingRequestDecorator < GenericResourceDecorator
  decorates_association :resource

  delegate :address,
           :telefono,
           :provider,
           :card_attributes,
           :customer_order_delivery,
           to: :resource_delegate

  def to_s
    title
  end

  def admin_link_to_resource(options=nil, &block)
    h.link_to(
      h.admin_shipping_request_path(object.id),
      options,
      &block
    )
  end

  def detail_attributes
    card_attributes + [
      :reason
    ]
  end

  def title
    I18n.t("admin.shipping_request.title") + " ##{object.id}"
  end

  def created_at
    I18n.l(object.created_at, format: :admin_full)
  end

  private

  def resource_delegate
    suffix = "#{kind}_delegate".classify
    klass = "#{self.class}::#{suffix}".constantize
    @resource_delegate ||= klass.new(self)
  end
end
