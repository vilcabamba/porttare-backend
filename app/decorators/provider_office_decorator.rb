class ProviderOfficeDecorator < Draper::Decorator
  delegate_all

  def title
    I18n.t("admin.provider_office.title") + " #{object.direccion}"
  end

  def link_to_resource(&block)
    h.content_tag :span, &block
  end
end
