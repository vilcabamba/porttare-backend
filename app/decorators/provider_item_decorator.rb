class ProviderItemDecorator < GenericResourceDecorator
  decorates_association :provider_profile
  decorates_association :provider_item_category

  def main_image_url
    if imagenes.any?
      imagenes.first.imagen_url
    end
  end

  def card_attributes
    [
      :precio,
      :en_stock,
      :provider_item_category
    ]
  end

  def precio
    h.humanized_money_with_symbol object.precio
  end

  def en_stock
    object.en_stock ? h.t("ui.positive") : h.t("ui.negative")
  end
end
