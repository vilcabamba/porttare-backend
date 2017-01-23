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

  def in_store?
    is_courier? && assigned_and_belongs_to_courier?
  end

  private

  def is_courier?
    user.courier_profile.present?
  end

  def assigned_and_belongs_to_courier?
    record.status.assigned? && record.courier_profile == user.courier_profile
  end
end
