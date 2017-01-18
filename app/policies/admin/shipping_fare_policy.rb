module Admin
  class ShippingFarePolicy < BasePolicy
    class Scope < Scope
      def resolve
        scope
      end
    end

    def new?
      privileges.customer_service? || privileges.admin?
    end

    def create?
      new?
    end

    def edit?
      new?
    end

    def update?
      edit?
    end

    def permitted_attributes
      [
        :price_cents
      ]
    end
  end
end
