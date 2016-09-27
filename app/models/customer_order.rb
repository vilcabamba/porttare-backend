# == Schema Information
#
# Table name: customer_orders
#
#  id                      :integer          not null, primary key
#  status                  :integer          default(0), not null
#  subtotal_items_cents    :integer          default(0), not null
#  subtotal_items_currency :string           default("USD"), not null
#  customer_profile_id     :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class CustomerOrder < ActiveRecord::Base
  STATUSES = [
    "in_progress",
    "submitted"
  ].freeze

  enum status: STATUSES

  monetize :subtotal_items_cents,
           numericality: false

  validates :status,
            inclusion: { in: STATUSES }

  belongs_to :customer_profile
  has_many :order_items,
           class_name: "CustomerOrderItem"

  scope :in_progress, -> { where(status: "in_progress") }

  ##
  # transitions to submitted state
  # and caches subtotal_items
  def submit!
    update_subtotal_items!
  end

  ##
  # caches subtotal_items
  def update_subtotal_items!
    order_items.collect do |order_item|
      order_item.cache_provider_item_precio!
      order_item.cantidad * order_item.provider_item_precio
    end
  end
end
