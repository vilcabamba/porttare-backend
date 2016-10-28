class CustomerAddressPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(
        customer_profile_id: user.customer_profile.id
      )
    end
  end

  def permitted_attributes
    [
      :ciudad,
      :parroquia,
      :barrio,
      :direccion_uno,
      :direccion_dos,
      :codigo_postal,
      :referencia,
      :numero_convencional,
      :customer_profile_id
    ]
  end

  def index?
    true
  end

  def create?
    is_customer?
  end

  private

  def is_customer?
    user.customer_profile.present?
  end
end
