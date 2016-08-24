class ProviderCategoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all # all visible ATM
    end
  end
end
