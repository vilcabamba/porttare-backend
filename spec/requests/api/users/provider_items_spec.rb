require "rails_helper"

RSpec.describe Api::Provider::ItemsController,
               type: :request do
  describe "non-provider can't create items" do
    let(:user) { create :user }
    before { login_as user }
    it {
      post_with_headers "/api/provider/items"
    }
  end

  describe "as provider" do
    let(:provider) { create :user, :provider }
    before { login_as provider }
  end
end
