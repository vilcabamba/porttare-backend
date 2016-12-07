class ProviderCategoryDecorator < Draper::Decorator
  delegate_all

  def to_s
    titulo
  end
end
