class CustomerProfilePolicy < ApplicationPolicy
  def permitted_attributes
    [
      :name,
      :email,
      :password,
      customer_profile_attributes: [
        :fecha_de_nacimiento,
        :ciudad
      ]
    ]
  end
end
