require "rails_helper"

RSpec.describe Api::Customer::ProfilesController,
               type: :request do
  let(:user) { create :user }
  let(:another_user) { create :user }
  before { login_as user }

  describe "show customer profile information" do
    let(:customer_profile) {
      create :customer_profile,
             user: user
    }

    let(:customer_profile_another_user) {
      create :customer_profile,
             user: another_user
    }

    before do
      customer_profile
      customer_profile_another_user
      get_with_headers "/api/customer/profile"
    end

    let(:json) {
      JSON.parse response.body
    }

    let(:customer_profile_from_response) {
      providers = json["customer_profile"]
    }

    it "should match user" do
      expect(
        customer_profile_from_response["name"]
      ).to eq(customer_profile.user.name)

      expect(
        customer_profile_from_response["email"]
      ).to eq(customer_profile.user.email)

      expect(
        customer_profile_from_response["name"]
      ).to_not eq(customer_profile_another_user.user.name)

      expect(
        customer_profile_from_response["email"]
      ).to_not eq(customer_profile_another_user.user.email)
    end

    it "includes full customer profile" do
      expect(
        customer_profile_from_response
      ).to have_key("fecha_de_nacimiento")

      expect(
        customer_profile_from_response
      ).to have_key("ciudad")

      expect(
        customer_profile_from_response
      ).to have_key("customer_addresses")
    end

    it "should not include user password" do
      expect(
        customer_profile_from_response
      ).to_not have_key("password")
    end
  end
end
