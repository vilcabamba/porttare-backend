require "rails_helper"

RSpec.describe Api::CategoriesController,
               type: :request do
  let(:user) { create :user }
  before { login_as user }

  describe "lists categories and providers" do
    before do
      category
      provider_profile
      get_with_headers "/api/categories"
    end

    let(:category) {
      create :provider_category,
             titulo: "Alimentos preparados"
    }
    let(:provider_profile) {
      create :provider_profile,
             provider_category: category
    }

    it "should include category" do
      expect(
        response.body
      ).to include("Alimentos preparados")
    end

    it "includes provider inside category" do
      expect(
        response.body
      ).to include(provider_profile.razon_social)
    end

    it "doesn't include full provider info" do
      json = JSON.parse response.body
      expect(
        json["category"]["providers"].first
      ).to_not have_key("offices")
    end
  end
end
