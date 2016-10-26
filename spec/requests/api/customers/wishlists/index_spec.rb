require "rails_helper"

RSpec.describe Api::Customer::WishlistsController,
               type: :request do
  before { login_as user }

  let(:response_wishlists) {
    JSON.parse(response.body).fetch("customer_wishlists")
  }

  describe "non-customer" do
    let(:user) { create :user }

    before do
      expect {
        get_with_headers "/api/customer/wishlists"
      }.to_not change(CustomerWishlist, :count)
    end

    it "doesn't create any customer profile" do
      expect(
        user.customer_profile
      ).to_not be_present
    end

    it "response is empty" do
      expect(
        response_wishlists
      ).to be_empty
    end
  end

  describe "customer" do

  end
end
