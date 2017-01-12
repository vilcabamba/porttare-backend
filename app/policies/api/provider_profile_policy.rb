module Api
  class ProviderProfilePolicy < ::ApplicationPolicy
    class PublicScope < Scope
      def resolve
        scope.with_status(:active)
             .for_place(user.current_place)
      end
    end
  end
end
