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
#  forma_de_pago                       :integer
#  observaciones                       :text
#  customer_billing_address_attributes :text
#  customer_billing_address_id         :integer
#  submitted_at                        :datetime
#

class CustomerOrder < ActiveRecord::Base
  STATUSES = [
    "in_progress",
    "submitted"
  ].freeze
  FORMAS_DE_PAGO = [
    "efectivo"
  ].freeze

  enum status: STATUSES
  enum forma_de_pago: FORMAS_DE_PAGO

  monetize :subtotal_items_cents,
           numericality: false

  validates :status,
            inclusion: { in: STATUSES }
  validates :forma_de_pago,
            allow_nil: true,
            inclusion: { in: FORMAS_DE_PAGO }
  validates :customer_billing_address,
            own_address: true
  # validates :deliver_at, in_future: true

  belongs_to :customer_profile
  belongs_to :customer_address
  belongs_to :customer_billing_address
  has_many :deliveries,
           class_name: "CustomerOrderDelivery"
  # TODO should this be through deliveries?
  has_many :order_items,
           class_name: "CustomerOrderItem",
           dependent: :destroy

  accepts_nested_attributes_for :deliveries

  begin :scopes
    scope :submitted, -> {
      where status: statuses["submitted"]
    }
    scope :in_progress, -> {
      where status: statuses["in_progress"]
    }
    scope :latest, -> {
      order(created_at: :desc)
    }
  end

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
      cache_billing_addresses!
      update_subtotal_items!
      update_submitted_at!
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
  # writes submitted_at with current time
  def update_submitted_at!
    update_attribute :submitted_at, Time.now
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
    order_items.includes(provider_item: :imagenes)
               .select do |order_item|
      order_item.provider_item.provider_profile_id == provider_profile.id
    end
  end

  def delivery_for_provider(provider_profile)
    deliveries.detect do |delivery|
      delivery.provider_profile_id == provider_profile.id
    end
  end

  private

  def cache_billing_addresses!
    assign_attributes(
      customer_billing_address_attributes: customer_billing_address.attributes
    )
  end

  def cache_addresses!
    deliveries.each do |delivery|
      delivery.send :cache_address!
    end
  end
end
