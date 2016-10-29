module Admin
  class UsersController < BaseController
    before_action :authorize_resource
    before_action :find_user,
                  only: [:edit, :update]

    def index
      @users = users_scope.all
    end

    def new
      @user = users_scope.new
    end

    def edit
    end

    def create
      @user = users_scope.new(user_attributes)
      if @user.save
        redirect_to(
          { action: :index },
          notice: t("admin.users.created")
        )
      else
        render :new
      end
    end

    def update
      if @user.update_attributes(user_attributes)
        redirect_to(
          { action: :index },
          notice: t("admin.users.updated")
        )
      else
        render :edit
      end
    end

    private

    def user_attributes
      attributes = if params[:user][:password].present?
        policy(User).admin_permitted_attributes_with_password
      else
        policy(User).admin_permitted_attributes
      end
      params.require(:user)
            .permit(attributes)
    end

    def authorize_resource
      authorize User, :manage?
    end

    def find_user
      @user = users_scope.find params[:id]
    end

    def users_scope
      skip_policy_scope
      UserPolicy::AdminScope.new(pundit_user, User).resolve
    end
  end
end
