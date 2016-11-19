module Admin
  class ProviderProfilePolicy < ::ApplicationPolicy
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

    def transition?(to_status)
      case to_status.to_s
      when "ask_to_validate"
        privileges.customer_service? || privileges.admin?
      end
    end

    private

    def privileges
      user.privileges
    end
  end
end
