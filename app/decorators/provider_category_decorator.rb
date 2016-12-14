class ProviderCategoryDecorator < GenericResourceDecorator
  def to_s
    titulo
  end

  def card_attributes
    [:titulo, :descripcion]
  end
end
