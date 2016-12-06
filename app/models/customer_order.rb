# == Schema Information
#
# Table name: customer_orders
#
#  id                                  :integer          not null, primary key
#  status                              :integer          default(0), not null
#  subtotal_items_cents                :integer          default(0), not null
#  subtotal_items_currency             :string           default("USD"), not null
#  customer_profile_id                 :integer          not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  deliver_at                          :datetime
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
  validates :customer_address,
            :customer_billing_address,
            own_address: true
  validates :deliver_at, in_future: true

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
  # and caches:
  #  - subtotal_items
  #  - customer_address
  #  - customer_billing_address
  def submit!
    transaction do
      cache_addresses!
      update_subtotal_items!
      submitted!
      save
    end
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

  def provider_profiles
    ProviderProfile.where(
      id: provider_items.pluck(:provider_profile_id)
    )
  end

  def provider_items
    ProviderItem.where(
      id: order_items.pluck(:provider_item_id)
    )
  end

  def order_items_by_provider(provider_profile)
    order_items.select do |order_item|
      order_item.provider_item.provider_profile_id == provider_profile.id
    end
  end

  private

  ##
  # assigns cached addresses
  # customer_address is cached if present
  # customer_billing_address is always cached
  def cache_addresses!
    assign_attributes(
      customer_address_attributes: customer_address.try(:attributes),
      customer_billing_address_attributes: customer_billing_address.attributes
    )
  end
end
