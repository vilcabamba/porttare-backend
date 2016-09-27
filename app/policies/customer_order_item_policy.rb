class CustomerOrderItemPolicy < ApplicationPolicy
  def permitted_attributes
    [
      :cantidad,
      :observaciones,
      :provider_item_id
    ]
  end
end
