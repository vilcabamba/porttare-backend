class ProviderItemPolicy < ApplicationPolicy
  def create?
    # if the user is a provider
    user.provider_profile.present?
  end

  def permitted_attributes
    [
      :titulo,
      :descripcion,
      :unidad_medida,
      :precio,
      :volumen,
      :peso,
      :imagen,
      :observaciones
    ]
  end
end
