class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.find_by(id: user.id)
    end
  end

  class AdminScope < Scope
    def resolve
      scope
    end
  end

  def manage?
    is_admin?
  end

  def show?
    true
  end

  def update?
    true
  end

  def permitted_attributes
    [
      :name,
      :nickname,
      :image,
      :email,
      :ciudad,
      :fecha_nacimiento
    ]
  end

  def admin_permitted_attributes
    permitted_attributes + [
      :admin
    ]
  end

  def permitted_attributes_with_password
    # programatically permit the following so
    # we don't mistakenly override
    permitted_attributes + [
      :password
    ]
  end

  def admin_permitted_attributes_with_password
    admin_permitted_attributes + [
      :password,
      :password_confirmation
    ]
  end

  private

  def is_admin?
    user.privileges.admin?
  end
end
