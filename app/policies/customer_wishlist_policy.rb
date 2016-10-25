class CustomerWishlistPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(
        customer_profile_id: user.customer_profile.id
      )
    end
  end

  def permitted_attributes
    [
      :nombre,
      :entregar_en,
      provider_items_ids: []
    ]
  end

  def update?
    is_customer?
  end

  private

  def is_customer?
    user.customer_profile.present?
  end
end
