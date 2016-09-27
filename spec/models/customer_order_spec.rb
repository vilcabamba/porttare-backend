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

require 'rails_helper'

RSpec.describe CustomerOrder,
               type: :model do
  describe "factory" do
    subject { build :customer_order }
    it { is_expected.to be_valid }
    it "default status" do
      is_expected.to be_in_progress
    end
  end

  describe "#in_progress scope" do
    let(:customer_order_in_progress) {
      create :customer_order, status: :in_progress
    }

    let(:customer_order_submitted) {
      create :customer_order, status: :submitted
    }

    before do
      customer_order_submitted
      customer_order_in_progress
    end

    subject { described_class.in_progress }

    it {
      is_expected.to include(customer_order_in_progress)
      is_expected.to_not include(customer_order_submitted)
    }
  end
end
