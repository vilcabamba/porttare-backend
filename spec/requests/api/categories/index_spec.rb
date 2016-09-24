require "rails_helper"

RSpec.describe Api::CategoriesController,
               type: :request do
  let(:user) { create :user }
  before { login_as user }

  describe "lists categories and providers" do
    before do
      provider_category
      provider_profile
      get_with_headers "/api/categories"
    end

    let(:provider_category) {
      create :provider_category,
             titulo: "Alimentos preparados"
    }
    let(:provider_profile) {
      create :provider_profile,
             provider_category: provider_category
    }

    it "should include category" do
      expect(
        response.body
      ).to include("Alimentos preparados")
    end

    it "includes provider inside category" do
      expect(
        response.body
      ).to include(provider_profile.nombre_establecimiento)
    end

    it "doesn't include full provider info" do
      json = JSON.parse response.body
      response_category = json["provider_categories"].first
      expect(
        response_category["provider_profiles"].first
      ).to_not have_key("offices")
    end
  end
end
