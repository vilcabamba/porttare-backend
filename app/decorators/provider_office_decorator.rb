class ProviderOfficeDecorator < GenericResourceDecorator
  decorates_association :weekdays

  def to_s
    title
  end

  def title
    I18n.t("admin.provider_office.title") + " #{object.direccion}"
  end

  def hora_de_apertura
    office_time :hora_de_apertura
  end

  def hora_de_cierre
    office_time :hora_de_cierre
  end

  def inicio_de_labores
    weekday :inicio_de_labores
  end

  def final_de_labores
    weekday :final_de_labores
  end

  def enabled
    h.t("views.boolean.#{object.enabled.to_s}")
  end

  def detail_attributes
    [
      :enabled,
      :direccion,
      :telefono,
      :hora_de_apertura,
      :hora_de_cierre,
      :inicio_de_labores,
      :final_de_labores,
      :ciudad
    ].freeze
  end

  def history_parsed_fields

  end

  private

  def weekday(field)
    object.send("#{field}_text")
  end

  def office_time(field)
    if object.send(field).present?
      h.l(
        object.send(field).in_time_zone,
        format: :office_schedule
      )
    end
  end
end
