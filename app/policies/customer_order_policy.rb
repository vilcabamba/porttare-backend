class CustomerOrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(
        customer_profile_id: user.customer_profile.id
      )
    end
  end

  def index?
    true # non-customers may access this endpoint
  end

  ##
  # scope is not being used.
  # controllers access via #current_order
  def permitted_attributes
    [
      :deliver_at,
      :forma_de_pago,
      :observaciones,
      :delivery_method,
      :customer_address_id,
      :customer_billing_address_id
    ]
  end

  def checkout?
    belongs_to_user? && record.in_progress?
  end

  private

  def belongs_to_user?
    user.customer_profile == record.customer_profile
  end
end
