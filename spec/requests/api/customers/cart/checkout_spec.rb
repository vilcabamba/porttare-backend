require "rails_helper"

RSpec.describe Api::Customer::Cart::CheckoutsController,
               type: :request do
  let(:user) { create :user, :customer }
  before { login_as user }

  describe "submits my order" do
    let(:current_order) {
      create :customer_order,
             customer_profile: user.customer_profile
    }
    let(:order_item) {
      create :customer_order_item,
             customer_order: current_order
    }
    let(:customer_address) {
      create :customer_address,
             customer_profile: user.customer_profile
    }
    let(:customer_billing_address) {
      create :customer_billing_address,
             customer_profile: user.customer_profile
    }
    let(:response_order) {
      JSON.parse(response.body).fetch("customer_order")
    }
    let(:submission_attributes) {
      {
        forma_de_pago: "efectivo",
        observaciones: "something",
        delivery_method: "shipping",
        customer_address_id: customer_address.id,
        customer_billing_address_id: customer_billing_address.id
      }
    }

    before do
      current_order
      order_item

      post_with_headers(
        "/api/customer/cart/checkout",
        submission_attributes
      )
    end

    describe "invalid - without address" do
      let(:submission_attributes) {
        {
          forma_de_pago: "efectivo",
          delivery_method: "shipping",
          customer_billing_address_id: customer_billing_address.id
        }
      }
      it {
        errors = JSON.parse(response.body).fetch("errors")
        expect(errors).to have_key("customer_address_id")
      }
    end

    describe "successful submission" do
      it "order is persisted" do
        expect(
          response_order["status"]
        ).to eq("submitted")
        expect(
          response_order["observaciones"]
        ).to eq(submission_attributes[:observaciones])
      end
    end

    describe "successful - without address (pickup)" do
      let(:submission_attributes) {
        {
          forma_de_pago: "efectivo",
          delivery_method: "pickup",
          customer_billing_address_id: customer_billing_address.id
        }
      }
      it {
        expect(
          response_order["status"]
        ).to eq("submitted")
        expect(
          response_order["delivery_method"]
        ).to eq("pickup")
      }
    end

    describe "discounts" do
      pending
    end
  end
end
