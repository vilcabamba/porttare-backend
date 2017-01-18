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
        price: get_price,
        extra_price_per_km: extra_price_per_km,
        price_per_km: price_per_km,
        shipping_fare: shipping_fare
      }
    end

    private

    def shipping_fare
      price_cents = @place.total_price_cents_per_km_with_distance(@distance).round
      fare = @place.shipping_fares.object.find_by(price_cents: price_cents)
      if fare.blank?
        fare = @place.shipping_fares.object.where(
          "price_cents > :price_cents",
          price_cents: price_cents
        ).sorted.first
      end
      if fare.blank?
        fare = @place.object.shipping_fares.bigger.first
      end
      fare.price_cents / 100.0
    end

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
      extra_price_per_km + (@place.price_per_km_cents / 100.0)
    end

    def extra_price_per_km
      @place.extra_price_cents_per_km_with_distance(@distance) / 100.0
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

    def get_price
      @place.total_price_cents_per_km_with_distance(@distance) / 100.0
    end
  end
end
