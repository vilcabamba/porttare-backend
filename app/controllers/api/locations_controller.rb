module Api
  class LocationsController < BaseController
    before_action :authenticate_api_auth_user!

    api :POST,
        "/locations",
        "store current user's location"
    param :lat, String, required: true
    param :lon, String, required: true
    def create
      current_api_auth_user.locations.create!(location_params)
      head :created
    end

    private

    def location_params
      params.permit(:lat, :lon)
    end
  end
end
