require "rails_helper"

RSpec.describe Api::Customer::OrdersController,
               type: :request do
  let(:user) { create :user, :customer }
  before { login_as user }

  describe "I can cancel a recent order" do
    it {
      recent_order = create(
        :customer_order,
        :submitted,
        customer_profile: user.customer_profile
      )
      delivery = create(
        :customer_order_delivery,
        customer_order: recent_order,
        status: :accepted,
        provider_responded_at: Time.now
      )
      post_with_headers(
        "/api/customer/orders/#{recent_order.id}/deliveries/#{delivery.id}/cancel"
      )
      response_delivery = JSON.parse(
        response.body
      ).fetch("customer_order_delivery")
      expect(response_delivery["status"]).to eq("canceled")
    }
  end

  describe "I can't cancel an old order" do
    it {
      recent_order = create(
        :customer_order,
        :submitted,
        customer_profile: user.customer_profile
      )
      post_with_headers(
        "/api/customer/orders/#{recent_order.id}/cancel"
      )
      response_order = JSON.parse(response.body).fetch("customer_order")
      expect(response_order["status"]).to eq("canceled")
    }
  end
end
