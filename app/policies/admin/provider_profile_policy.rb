module Admin
  class ProviderProfilePolicy < BasePolicy
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

    def new?
      privileges.customer_service? || privileges.admin?
    end

    def transition?(to_status)
      case to_status.to_s
      when "ask_to_validate"
        privileges.customer_service? || privileges.admin?
      when "validated"
        privileges.customer_service? || privileges.admin?
      end
    end
  end
end
