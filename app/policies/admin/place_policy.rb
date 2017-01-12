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
  end
end
