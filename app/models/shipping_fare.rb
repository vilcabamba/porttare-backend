# == Schema Information
#
# Table name: shipping_fares
#
#  id             :integer          not null, primary key
#  place_id       :integer          not null
#  price_cents    :integer          default(0), not null
#  price_currency :string           default("USD"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ShippingFare < ActiveRecord::Base
  belongs_to :place

  validates :place_id,
            :price_cents,
            presence: true
end
