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

require 'rails_helper'

RSpec.describe CustomerOrderItem,
               type: :model do
  describe "factory" do
    subject { build :customer_order_item }
    it { is_expected.to be_valid }
  end

  describe "allows saving without caching provider item precio" do
    subject { create :customer_order_item }
    it {
      expect(
        subject[:provider_item_precio_cents]
      ).to_not be_present
    }
  end

  describe "#provider_item_precio" do
    describe "order not submitted, value calculated" do
      let(:customer_order) { create :customer_order }
      let(:order_item) {
        create :customer_order_item,
               customer_order: customer_order
      }
      let(:provider_item) { order_item.provider_item }

      it {
        expect(
          order_item.provider_item_precio
        ).to eq(provider_item.precio)

        expect(
          order_item.reload[:provider_item_precio_cents]
        ).to_not be_present
      }
    end

    describe "when order is submitted and value is cached" do
      let(:customer_order) { create :customer_order }
      let(:order_item) {
        create :customer_order_item,
               customer_order: customer_order
      }
      let(:provider_item) { order_item.provider_item }
      let(:new_price) {
        provider_item.precio + Money.from_amount(1.99, "USD")
      }

      before do
        order_item
        customer_order.submit!
        # and then update item's precio so we
        # verify cached version doesn't change
        provider_item.update! precio: new_price
      end

      it {
        expect(
          order_item.reload[:provider_item_precio_cents]
        ).to be_present

        expect(
          order_item.provider_item_precio
        ).to_not eq(new_price)
      }
    end
  end

  describe "updates customer_order #subtotal_items" do
    let(:customer_order) {
      customer_order_item.customer_order
    }

    describe "upon creation" do
      let(:customer_order_item) {
        create :customer_order_item
      }

      it {
        subtotal = customer_order_item.cantidad * customer_order_item.provider_item_precio
        expect(
          customer_order.subtotal_items
        ).to eq(subtotal)
      }
    end
  end
end
