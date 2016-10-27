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
    let(:user) { create :user, :customer }

    let(:other_wishlist) { create :customer_wishlist }
    let(:my_wishlist) {
      create :customer_wishlist,
             customer_profile: user.customer_profile
    }

    before do
      my_wishlist
      other_wishlist

      get_with_headers "/api/customer/wishlists"
    end

    it "includes my wishlist" do
      my_response_wishlist = response_wishlists.detect do |wishlist|
        wishlist["id"] == my_wishlist.id
      end
      expect(my_response_wishlist).to be_present
    end

    it "doesn't include other's wishlists" do
      expect(
        response_wishlists.detect do |wishlist|
          wishlist["id"] == other_wishlist.id
        end
      ).to_not be_present
    end
  end
end
