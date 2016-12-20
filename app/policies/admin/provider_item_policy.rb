module Admin
  class ProviderItemPolicy < BasePolicy
    class Scope < Scope
      def resolve
        scope
      end
    end

    def index?
      privileges.customer_service? || privileges.admin?
    end

    def show?
      index?
    end

    def edit?
      privileges.customer_service? || privileges.admin?
    end

    def new?
      privileges.customer_service? || privileges.admin?
    end

    def create?
      new?
    end

    def update?
      edit?
    end
  end
end
