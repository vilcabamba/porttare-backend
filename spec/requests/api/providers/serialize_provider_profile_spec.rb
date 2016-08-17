require "rails_helper"

RSpec.describe Api::Provider,
               type: :request do
  describe "provider profile id is serialized as part of user" do
    let(:user) { create :user, :provider }
    before { login_as user }

    let(:response_provider_profile_id) {
      JSON.parse(response.body)["data"]["provider_profile_id"]
    }

    it {
      expect(
        response_provider_profile_id
      ).to eq(user.provider_profile.id)
    }
  end
end
