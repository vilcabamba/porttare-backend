# == Schema Information
#
# Table name: customer_order_items
#
#  id                            :integer          not null, primary key
#  customer_order_id             :integer          not null
#  provider_item_id              :integer          not null
#  provider_item_precio_cents    :integer          not null
#  provider_item_precio_currency :string           default("USD"), not null
#  cantidad                      :integer          default(1), not null
#  observaciones                 :text
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#

class CustomerOrderItem < ActiveRecord::Base
  belongs_to :customer_order
  belongs_to :provider_item

  monetize :provider_item_precio_cents,
           numericality: false,
           allow_nil: true

  validates :cantidad,
            numericality: {
              greater_than: 0,
              only_integer: true
            }
  validates :provider_item_precio_cents,
            allow_nil: true,
            numericality: {
              greater_than: 0
            }
end
