class ProviderClientPolicy < ApplicationPolicy

  def create?
    user.provider_profile.present?
  end

  def permitted_attributes
    [
      :notas,
      :ruc,
      :nombres,
      :direccion,
      :telefono,
      :email
    ]
  end
end
