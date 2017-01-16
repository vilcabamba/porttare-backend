module Admin
  class ShippingCostsController < BaseController
    def show
      skip_policy_scope
      skip_authorization
      find_place
    end

    def calculate
      skip_policy_scope
      skip_authorization
      find_place
      assign_place_attributes
      set_target
      @distance = get_distance_to_target
      render json: {
        distance: @distance,
        distance_price: get_price_for_distance,
        price: get_price,
        price_per_km: price_per_km
      }
    end

    private

    def assign_place_attributes
      @place.assign_attributes(
        params.require(:place).permit(
          :price_per_km_cents,
          :factor_per_distance
        )
      )
    end

    def find_place
      @place = Admin::PlacePolicy::Scope.new(
        pundit_user,
        Place
      ).resolve.find(params[:place_id]).decorate
    end

    def price_per_km
      @place.price_per_km_with_distance(@distance)
    end

    def get_distance_to_target
      current_location = Geokit::LatLng.new(
        @place.lat,
        @place.lon
      )
      current_location.distance_to(@target)
    end

    def set_target
      @target = "#{params[:lat]},#{params[:lon]}"
    end

    def get_price_for_distance
      @place.price_per_km * @place.factor_per_distance * @distance
    end

    def get_price
      price_per_km * @distance
    end
  end
end
