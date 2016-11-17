module Admin
  class ProviderProfilePolicy < ::ApplicationPolicy
    class Scope < Scope
      def resolve
        scope
      end
    end

    def index?
      user.privileges.customer_service? || user.privileges.admin?
    end

    def show?
      index?
    end
  end
end
