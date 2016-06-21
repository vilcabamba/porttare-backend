require "rails_helper"

RSpec.describe Api::LocationsController,
               type: :request do
  describe "registers new location for user" do
    let(:user) { create :user }
    before { login_as user }

    it {
      expect {
        post_with_headers(
          "/api/locations",
          attributes_for(:user_location)
        )
      }.to change {
        user.locations.count
      }.by(1)
    }
  end
end
