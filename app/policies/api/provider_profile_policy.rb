module Api
  class ProviderProfilePolicy < ::ApplicationPolicy
    class PublicScope < Scope
      def resolve
        scope.with_status(:active)
             .for_place(user.current_place)
      end
    end

    def customer_show?
      user.current_place.present?
    end
  end
end
