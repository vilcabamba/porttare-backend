module Api
  module User
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
    end
  end
end
