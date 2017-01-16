class ProviderOfficeDecorator < GenericResourceDecorator
  decorates_association :place
  decorates_association :weekdays

  def to_s
    title
  end

  def title
    I18n.t("admin.provider_office.title") + " #{object.direccion}"
  end

  def enabled
    h.t("views.boolean.#{object.enabled.to_s}")
  end

  def detail_attributes
    [
      :enabled,
      :direccion,
      :telefono,
      :place
    ].freeze
  end
end
