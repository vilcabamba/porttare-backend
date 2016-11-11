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

    before do
      current_order
      order_item

      post_with_headers(
        "/api/customer/cart/checkout",
        submission_attributes
      )
    end

    describe "with new address" do
      let(:submission_attributes) {
        {
          forma_de_pago: "efectivo",
          observaciones: "",
          direccion_entrega: {
            calles: "",
            referencia: "",
            telefono: ""
          },
          direccion_facturacion: {
            ruc: "",
            razon_social: "",
            telefono: "",
            direccion: "",
            email: ""
          }
        }
      }
    end

    describe "with old address" do

    end

    describe "without address (pickup)" do

    end

    describe "new billing address" do

    end

    describe "old billing address" do

    end

    describe "discounts" do
      pending
    end
  end
end
