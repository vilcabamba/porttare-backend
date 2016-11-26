class ShippingRequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.with_status(:new)
    end
  end

  def index?
    user.courier_profile.present?
  end
end
