# == Schema Information
#
# Table name: customer_profiles
#
#  id                  :integer          not null, primary key
#  user_id             :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  fecha_de_nacimiento :date
#  ciudad              :string
#

class CustomerProfile < ActiveRecord::Base
  belongs_to :user
  has_many :customer_orders
  has_many :customer_wishlists
  has_many :customer_addresses
  
  ##
  # returns an order in progress (if any)
  # @return CustomerOrder
  def current_order
    customer_orders.in_progress.first
  end
end
