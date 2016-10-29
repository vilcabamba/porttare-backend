class ProviderCategoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all # all visible ATM
    end
  end

  def index?
    true
  end

  def show?
    true
  end
end
