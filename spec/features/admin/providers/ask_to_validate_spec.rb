require "rails_helper"

describe %q{
  As atención al cliente
  I can verify provider applications
} do
  let(:user) { create :user, :customer_service }
  before {
    user
    login_as_admin user
  }

  feature "verify provider application" do
    let(:provider_profile) {
      create :provider_profile, status: :applied
    }

    before {
      provider_profile
      visit admin_provider_path(provider_profile)
    }

    it "persists a version for history", versioning: true do
      validate_text = "admin.provider_profile.transition.ask_to_validate"

      expect {
        click_on I18n.t(validate_text)
      }.to change {
        PaperTrail::Version.where(event: :ask_to_validate).count
      }.by(1)

      expect(
        provider_profile.reload.status
      ).to eq("ask_to_validate")

      # creates a shipping request to validate
      # the provider
      shipping_request = ShippingRequest.last
      expect(
        shipping_request.resource
      ).to eq(provider_profile)
      expect(
        shipping_request.kind
      ).to eq("ask_to_validate")
    end
  end
end
