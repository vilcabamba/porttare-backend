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
#  reason                      :text
#  shipping_fare_price_cents   :integer
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

  enumerize :delivery_method,
            in: DELIVERY_METHODS,
            i18n_scope: "customer_order_delivery.delivery_method"
  enumerize :status,
            in: %w(draft pending accepted rejected),
            default: "draft",
            scope: true,
            i18n_scope: "customer_order_delivery.status"

  monetize :shipping_fare_price_cents

  def ready_for_submission?
    delivery_method.present? &&
      (delivery_method.pickup? || customer_address_id.present?)
  end

  def customer_address_or_default
    customer_address.presence || default_customer_address
  end

  def default_customer_address
    if delivery_method.shipping?
      customer_profile.default_customer_address
    end
  end

  def shipping_fare_price_cents
    cached_price = read_attribute(:shipping_fare_price_cents)
    cached_price.presence || shipping_cost_calculator.try(:shipping_fare_price_cents)
  end

  def closest_provider_office
    return if customer_address.blank?
    provider_profile
      .offices
      .for_place(customer_order.place)
      .enabled
      .closest(origin: [
        customer_address.lat,
        customer_address.lon
      ])
      .first
  end

  private

  def shipping_cost_calculator
    if delivery_method.shipping? && customer_address.present?
      ShippingCostCalculatorService.for_customer_order_delivery(self)
    end
  end

  def cache_address!
    assign_attributes(
      customer_address_attributes: customer_address.try(:attributes)
    )
  end

  def cache_shipping_fare_price_cents!
    assign_attributes(
      shipping_fare_price_cents: shipping_cost_calculator.try(:shipping_fare_price_cents)
    )
  end
end
