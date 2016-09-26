# == Schema Information
#
# Table name: customer_profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CustomerProfile < ActiveRecord::Base
  belongs_to :user
  has_many :customer_orders

  ##
  # should always return an order in
  # progress, usable for cart
  # @return CustomerOrder
  def current_order
    customer_orders.in_progress.first || customer_orders.create
  end
end
