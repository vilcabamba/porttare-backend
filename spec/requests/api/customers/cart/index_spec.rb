require "rails_helper"

RSpec.describe Api::Customer::Cart::ItemsController,
               type: :request do
  before do
    login_as user
  end

  let(:response_order) {
    JSON.parse(response.body).fetch("customer_order")
  }

  describe "non-customer" do
    let(:user) { create :user }

    before {
      # should not create any order
      expect {
        get_with_headers "/api/customer/cart"
      }.to_not change(CustomerOrder, :count)
    }

    it "should not create any customer profile" do
      expect(
        user.customer_profile
      ).to_not be_present
    end

    it "order is empty" do
      expect(
        response_order
      ).to be_nil
    end
  end

  describe "customer with no order" do
    let(:user) { create :user, :customer }

    before {
      # should not create any order
      expect {
        get_with_headers "/api/customer/cart"
      }.to_not change(CustomerOrder, :count)
    }

    it "order is empty" do
      expect(
        response_order
      ).to be_nil
    end
  end

  describe "customer with order" do

  end
end
