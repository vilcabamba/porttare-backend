module Api
  class LocationsController < BaseController
    before_action :authenticate_api_auth_user!

    respond_to :json

    api :POST,
        "/locations",
        "Store current user's location. Response includes previous locations and a boolean to say if this is a new location"
    description "we return up to 10 previous user locations and a boolean which says if this new location is far from the last one"
    param :lat, String, required: true
    param :lon, String, required: true
    example %q{{
  "previous_locations" : [
    { "lat": "-4.7921345", "lon": "73.4321424" }
  ],
  "meta" : {
    "new_location": true
  }
}}
    def create
      @previous_locations = get_previous_locations
      location = current_api_auth_user.locations.create!(location_params)
      @is_new_location = is_new_location?(location)
      render "previous_locations", status: :created
    end

    private

    def location_params
      params.permit(:lat, :lon)
    end

    def get_previous_locations
      current_api_auth_user.locations.limit(10).to_a
    end

    def is_new_location?(location)
      return false if @previous_locations.first.blank?
      %w(
        lat
        lon
      ).any? do |attribute|
        prev = @previous_locations.first.send(attribute).to_f
        actual = location.send(attribute).to_f
        diff = (prev - actual).abs
        diff.round(2) >= 0.01 # if any lat/lon diff is greater
      end
    end
  end
end
