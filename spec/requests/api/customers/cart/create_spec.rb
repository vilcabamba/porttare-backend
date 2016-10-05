require "rails_helper"

RSpec.describe Api::Customer::CartController,
               type: :request do
  let(:user) { create :user }
  before { login_as user }

  describe "adds an item to the cart" do
    let(:provider_item) { create :provider_item }
    let(:posted_attributes) {
      attributes_for(:customer_order_item)
    }

    before do
      provider_item

      expect {
        post_with_headers(
          "/api/customer/cart/items",
          posted_attributes.merge(
            provider_item_id: provider_item.id
          )
        )
      }.to change { CustomerOrder.count }.by(1)
    end

    it "customer_profile gets automatically created" do
      customer_profile = user.reload.customer_profile
      expect(customer_profile).to be_present
      expect(customer_profile).to be_persisted
    end

    it "should create right order_item" do
      customer_order = CustomerOrder.last
      order_items = customer_order.order_items

      expect(
        customer_order.customer_profile
      ).to eq(user.customer_profile)

      expect(
        order_items.count
      ).to eq(1)

      expect(
        order_items.first.cantidad
      ).to eq(posted_attributes[:cantidad])
    end

    it "should render whole order" do
      json = JSON.parse response.body
      customer_order = json["customer_order"]
      customer_order_item = customer_order["customer_order_items"].first

      expect(
        customer_order
      ).to have_key("status")

      expect(
        customer_order
      ).to have_key("subtotal_items_cents")

      expect(
        customer_order_item
      ).to have_key("cantidad")

      expect(
        customer_order_item
      ).to have_key("observaciones")
    end
  end
end
