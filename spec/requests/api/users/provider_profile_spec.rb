require "rails_helper"

RSpec.describe Api::User::ProviderProfilesController,
               type: :request do
  let(:user) { create :user }
  before { login_as user }

  describe "doesn't create provider profile for user" do
    before do
      post_with_headers(
        "/api/user/provider_profile",
        { invalid: :attributes }
      )
    end

    it {
      expect(user.reload.provider_profile).to be_nil
    }
  end

  describe "creates valid provider profile for user" do
    before do
      post_with_headers(
        "/api/user/provider_profile",
        attributes_for(:provider_profile) # TODO: define
      )
    end

    it {
      provider_profile = ProviderProfile.last
      expect(provider_profile.user).to eq(user)
    }
  end
end
