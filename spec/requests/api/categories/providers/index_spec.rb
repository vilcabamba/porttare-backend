require "rails_helper"

RSpec.describe Api::ProvidersController,
               type: :request do
  let(:user) { create :user }
  before { login_as user }

  describe "list of providers which belong to a category" do
    let(:category) { create :provider_category }
    let(:provider_profile){
      create :provider_profile,
             provider_category: category
    }

    before do
      category
      provider_profile
      get_with_headers "/api/categories/#{category.id}/providers"
    end

    let(:json) {
      JSON.parse response.body
    }

    let(:provider_from_response) {
      providers = json["category"]["providers"]
      provider = providers.detect do |provider|
        provider["id"] == provider_profile.id
      end
    }

    it "should include provider profile" do
      expect(provider_from_response).to be_present
    end

    it "includes complete info for provider profile" do
      # TODO
      expect(
        provider_from_response["offices"].first
      ).to have_key("horario")
    end
  end
end
