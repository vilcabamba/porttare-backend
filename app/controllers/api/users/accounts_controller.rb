module Api
  module Users
    class AccountsController < BaseController
      resource_description do
        name "User::Accounts"
        short "user's account"
      end

      before_action :authenticate_api_auth_user!

      api :GET,
          "/user/account",
          "User's account"
      example %q{{
  "user":{
    "id":2,
    "name":"Ana María Cornejo Vásquez",
    "email":"darlene@collierfranecki.biz",
    "ciudad":"Móstoles",
    "fecha_nacimiento":"1973-08-06"
  }
}}
      def show
        # TODO authorize
        # authorize User
        @user = current_api_auth_user
        skip_policy_scope # because rendering self user
      end

      def update
        # TODO authorize
        # authorize User
        @user = current_api_auth_user
        skip_policy_scope # because rendering self user
        if @user.update(user_params)
          render :show, status: :accepted
        else
          @errors = @user.errors
          render "api/shared/resource_error",
                 status: :unprocessable_entity
        end
      end

      private

      def user_params
        attributes = if params[:password].present?
          policy(User).permitted_attributes_with_password
        else
          policy(User).permitted_attributes
        end
        params.permit(attributes)
      end
    end
  end
end
