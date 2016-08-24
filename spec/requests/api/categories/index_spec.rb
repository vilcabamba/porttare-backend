require "rails_helper"

RSpec.describe Api::CategoriesController,
               type: :request do
  let(:user) { create :user }
  before { login_as user }

  describe "lists categories" do
    before do
      get_with_headers "/api/categories"
    end

    let!(:category) {
      create :provider_category,
             titulo: "Alimentos preparados"
    }

    it "should include category" do
      binding.pry
      expect(
        response.body
      ).to include("Alimentos preparados")
    end
  end
end
