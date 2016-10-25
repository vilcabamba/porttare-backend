require "rails_helper"

RSpec.describe Api::Customer::WishlistsController,
               type: :request do
  let(:user) { create :user }
  before { login_as user }

  describe "creates a wishlist" do
    let(:provider_item) { create :provider_item }
    let(:attributes) {
      attributes_for :customer_wishlist,
                     provider_items_ids: [provider_item.id]
    }

    let(:resp_customer_wishlist) {
      JSON.parse(response.body).fetch("customer_wishlist")
    }

    before do
      provider_item

      expect {
        post_with_headers(
          "/api/customer/wishlists",
          attributes
        )
      }.to change { CustomerWishlist.count }.by(1)
    end

    it "customer_profile gets automatically created" do
      customer_profile = user.reload.customer_profile
      expect(customer_profile).to be_persisted
    end

    it "customer_wishlist belongs to right customer_profile" do
      customer_wishlist = CustomerWishlist.last

      expect(
        customer_wishlist.customer_profile
      ).to eq(user.reload.customer_profile)
    end

    it "persists attributes" do
      expect(
        resp_customer_wishlist["nombre"]
      ).to eq(attributes[:nombre])

      # force current timezone
      Time.zone = Rails.application.config.time_zone
      expect(
        resp_customer_wishlist["entregar_en"]
      ).to eq(
        I18n.l(attributes[:entregar_en], format: :api)
      )

      expect(
        resp_customer_wishlist["provider_items_ids"]
      ).to include(provider_item.id.to_s)
    end
  end
end
