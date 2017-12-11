module Api
  class ProviderProfilePolicy < ::ApplicationPolicy
    class PublicScope < Scope
      def resolve
        if user
          scope.with_status(:active)
          .with_enabled_offices_in(user.current_place)
        else
          scope.with_status(:active)
          .with_enabled_offices_in(Place.default)
        end

      end
    end

    def customer_show?
      user.current_place.present? if user else true
    end
  end
end
