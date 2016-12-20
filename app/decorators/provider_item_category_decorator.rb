class ProviderItemCategoryDecorator < Draper::Decorator
  delegate_all
  decorates_association :provider_profile

  def to_s
    nombre
  end
end
