class ShippingRequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    is_courier?
  end

  def show?
    is_courier?
  end

  def take?
    is_courier? && record.status.new?
  end

  private

  def is_courier?
    user.courier_profile.present?
  end
end
