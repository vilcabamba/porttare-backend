class CustomerWishlistPolicy < ApplicationPolicy
  def permitted_attributes
    [
      :nombre,
      :entregar_en,
      provider_items_ids: []
    ]
  end
end
