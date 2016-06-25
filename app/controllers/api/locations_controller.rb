module Api
  class LocationsController < BaseController
    before_action :authenticate_api_auth_user!

    respond_to :json

    api :POST,
        "/locations",
        "store current user's location"
    param :lat, String, required: true
    param :lon, String, required: true
    def create
      @previous_locations = get_previous_locations
      current_api_auth_user.locations.create!(location_params)
      render "previous_locations", status: :created
    end

    private

    def location_params
      params.permit(:lat, :lon)
    end

    def get_previous_locations
      current_api_auth_user.locations.limit(10).to_a
    end
  end
end
