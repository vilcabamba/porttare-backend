require "rails_helper"

RSpec.describe Api::Customer::ProfilesController,
               type: :request do
  let(:user) { create :user }

  before { login_as user }

  let(:response_customer_profile) {
    JSON.parse(response.body).fetch("customer_profile")
  }

  describe "without personal info" do
    before { get_with_headers "/api/customer/profile" }

    it {
      expect(user.reload.customer_profile).to_not be_present
      expect(response_customer_profile).to be_nil
    }
  end

  describe "with personal info" do
    let(:customer_profile) {
      create :customer_profile,
             :with_info,
             user: user
    }

    before do
      customer_profile
      get_with_headers "/api/customer/profile"
    end

    it "should match user" do
      expect(
        response_customer_profile["name"]
      ).to eq(customer_profile.user.name)

      expect(
        response_customer_profile["email"]
      ).to eq(customer_profile.user.email)

      expect(
        response_customer_profile["name"]
      ).to_not eq(customer_profile_another_user.user.name)

      expect(
        response_customer_profile["email"]
      ).to_not eq(customer_profile_another_user.user.email)
    end

    it "includes full customer profile" do
      expect(
        response_customer_profile
      ).to have_key("fecha_de_nacimiento")

      expect(
        response_customer_profile
      ).to have_key("ciudad")

      expect(
        response_customer_profile
      ).to have_key("customer_addresses")
    end

    it "should not include user password" do
      expect(
        response_customer_profile
      ).to_not have_key("password")
    end
  end
end
