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
#

require 'rails_helper'

RSpec.describe CustomerOrderDelivery,
               type: :model do
  subject { build :customer_order_delivery }
  it { is_expected.to be_valid }
end
