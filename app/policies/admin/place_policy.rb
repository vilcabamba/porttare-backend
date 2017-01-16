module Admin
  class PlacePolicy < BasePolicy
    class Scope < Scope
      def resolve
        scope
      end
    end

    def index?
      privileges.customer_service? || privileges.admin?
    end

    def update?
      privileges.customer_service? || privileges.admin?
    end

    def permitted_attributes
      [
        :price_per_km_cents,
        :factor_per_distance
      ]
    end
  end
end
