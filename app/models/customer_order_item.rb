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

  ##
  # reads cached provider_item_precio if present
  # or asks the provider_item otherwise
  # @return [Money]
  def provider_item_precio
    cached_precio = read_attribute(:provider_item_precio_cents)
    if cached_precio.present?
      Money.new(
        cached_precio,
        provider_item_precio_currency # DB defaults it to USD
      )
    else
      provider_item.precio
    end
  end

  def cache_provider_item_precio!
    update_attribute(
      :provider_item_precio,
      provider_item.precio
    )
  end
end
