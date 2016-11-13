# == Schema Information
#
# Table name: customer_orders
#
#  id                                  :integer          not null, primary key
#  status                              :integer          default(0), not null
#  subtotal_items_cents                :integer          default(0), not null
#  subtotal_items_currency             :string           default("USD"), not null
#  customer_profile_id                 :integer
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  delivery_method                     :integer
#  forma_de_pago                       :integer
#  observaciones                       :text
#  customer_address_attributes         :text
#  customer_billing_address_attributes :text
#  customer_address_id                 :integer
#  customer_billing_address_id         :integer
#

class CustomerOrder < ActiveRecord::Base
  STATUSES = [
    "in_progress",
    "submitted"
  ].freeze
  FORMAS_DE_PAGO = [
    "efectivo"
  ].freeze
  DELIVERY_METHODS = [
    "shipping",
    "pickup"
  ].freeze

  enum status: STATUSES
  enum forma_de_pago: FORMAS_DE_PAGO
  enum delivery_method: DELIVERY_METHODS

  monetize :subtotal_items_cents,
           numericality: false

  validates :status,
            inclusion: { in: STATUSES }
  validates :forma_de_pago,
            allow_nil: true,
            inclusion: { in: FORMAS_DE_PAGO }
  validates :delivery_method,
            allow_nil: true,
            inclusion: { in: DELIVERY_METHODS }
  validate :own_customer_address, if: :customer_address
  validate :own_customer_billing_address, if: :customer_billing_address

  belongs_to :customer_profile
  belongs_to :customer_address
  belongs_to :customer_billing_address
  has_many :order_items,
           class_name: "CustomerOrderItem"

  scope :in_progress, -> { where(status: "in_progress") }

  serialize :customer_address_attributes, JSON
  serialize :customer_billing_address_attributes, JSON

  ##
  # transitions to submitted state
  # and caches subtotal_items
  def submit!
    update_subtotal_items!
  end

  ##
  # caches subtotal_items
  # and caches each order_item's provider_item_precio
  # @see #cache_subtotal_items!
  def update_subtotal_items!
    subtotal = order_items.collect do |order_item|
      order_item.cache_provider_item_precio!
      order_item.subtotal
    end.sum
    update_attribute(:subtotal_items, subtotal)
  end

  ##
  # caches subtotal_items
  # @see #update_subtotal_items!
  def cache_subtotal_items!
    # HACK: force reloading order_items so they're fresh
    # see spec/models/customer_order_spec
    order_items.reload

    update_attribute(
      :subtotal_items,
      order_items.collect(&:subtotal).sum
    )
  end

  private

  def own_customer_address
    if customer_address.customer_profile != customer_profile
      errors.add(:customer_address_id, :invalid)
    end
  end

  def own_customer_billing_address
    if customer_billing_address.customer_profile != customer_profile
      errors.add(:customer_billing_address_id, :invalid)
    end
  end
end
