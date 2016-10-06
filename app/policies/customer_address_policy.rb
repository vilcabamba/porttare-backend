class CustomerAddressPolicy < ApplicationPolicy
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
end
