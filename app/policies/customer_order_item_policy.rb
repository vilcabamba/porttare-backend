class CustomerOrderItemPolicy < ApplicationPolicy
  ##
  # scope is not being used.
  # controllers access via #current_order
  # class Scope < Scope
  #   def resolve
  #     scope.where(
  #       customer_order_id: user.customer_profile.customer_orders.pluck(:id)
  #     )
  #   end
  # end

  def permitted_attributes
    [
      :cantidad,
      :observaciones,
      :provider_item_id
    ]
  end

  def update?
    # all users can edit their own
    # order items within their order
    # in progress.
    # scope should be
    # provided by the class or this
    # method should verify the order's
    # ownership otherwise
    record.customer_order.in_progress?
  end
end
