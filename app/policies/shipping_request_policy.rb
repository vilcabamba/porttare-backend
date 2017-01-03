class ShippingRequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.with_status(:new)
    end
  end

  def index?
    is_courier?
  end

  def show?
    is_courier?
  end

  private

  def is_courier?
    user.courier_profile.present?
  end
end
