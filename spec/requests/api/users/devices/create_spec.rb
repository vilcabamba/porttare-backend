require "rails_helper"

RSpec.describe Api::Users::DevicesController,
               type: :request do
  let(:user) { create :user }
  let(:existing_user_device) { create(:user_device) }
  before { login_as user }

  it "updates device as mine" do
    existing_user_device

    post_with_headers(
      "/api/users/devices",
      uuid: existing_user_device.uuid
    )
    expect(response.status).to eq(200)
    json_response = JSON.parse(response.body)
    binding.pry
    expect(
      json_response["user_device"]["id"]
    ).to_not eq(existing_user_device.id)
  end
end
