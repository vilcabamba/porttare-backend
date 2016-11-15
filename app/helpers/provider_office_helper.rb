module ProviderOfficeHelper
  def localized_day(value)
    I18n.t("date.day_names")[value] if value.present?
  end
end
