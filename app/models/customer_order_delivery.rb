# == Schema Information
#
# Table name: customer_order_deliveries
#
#  id                          :integer          not null, primary key
#  deliver_at                  :datetime
#  delivery_method             :string           not null
#  customer_address_id         :integer
#  customer_address_attributes :json
#  provider_profile_id         :integer
#  customer_order_id           :integer          not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  status                      :string           default("draft"), not null
#

class CustomerOrderDelivery < ActiveRecord::Base
  extend Enumerize

  delegate :customer_profile,
           to: :customer_order

  DELIVERY_METHODS = [
    "shipping",
    "pickup"
  ].freeze

  validates :delivery_method,
            allow_nil: true,
            inclusion: { in: DELIVERY_METHODS }
  validates :customer_address,
            own_address: true
  validates :deliver_at, in_future: true

  belongs_to :customer_order
  belongs_to :customer_address
  belongs_to :provider_profile

  enumerize :delivery_method, in: DELIVERY_METHODS
  enumerize :status,
            in: %w(draft pending accepted rejected),
            default: "draft",
            scope: true

  def ready_for_submission?
    delivery_method.present? &&
      (delivery_method.pickup? || customer_address_id.present?)
  end

  private

  def cache_address!
    assign_attributes(
      customer_address_attributes: customer_address.try(:attributes)
    )
  end
end
