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

  def show?
    belongs_to_user?
  end

  ##
  # scope is not being used.
  # controllers access via #current_order
  def permitted_attributes
    [
      :forma_de_pago,
      :observaciones,
      :customer_billing_address_id,
      deliveries_attributes: [
        :provider_profile_id,
        :delivery_method,
        :customer_address_id,
        :deliver_at
      ]
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
