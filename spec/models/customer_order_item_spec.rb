# == Schema Information
#
# Table name: customer_order_items
#
#  id                            :integer          not null, primary key
#  customer_order_id             :integer          not null
#  provider_item_id              :integer          not null
#  provider_item_precio_cents    :integer          default(0), not null
#  provider_item_precio_currency :string           default("USD"), not null
#  cantidad                      :integer          default(1), not null
#  observaciones                 :text
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#

require 'rails_helper'

RSpec.describe CustomerOrderItem,
               type: :model do
  describe "factory" do
    subject { build :customer_order_item }
    it { is_expected.to be_valid }
  end
end
