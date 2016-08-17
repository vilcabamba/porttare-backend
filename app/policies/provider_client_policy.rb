class ProviderClientPolicy < ApplicationPolicy

  def create?
    user.provider_profile.present?
  end

  def permitted_attributes
    [
      :notes,
      :ruc,
      :name,
      :address,
      :phone,
      :email
    ]
  end
end
