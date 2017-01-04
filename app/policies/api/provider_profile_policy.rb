module Api
  class ProviderProfilePolicy < ::ApplicationPolicy
    class PublicScope < Scope
      def resolve
        scope.with_status(:active)
      end
    end
  end
end
