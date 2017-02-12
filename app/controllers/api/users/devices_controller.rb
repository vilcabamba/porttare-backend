module Api
  module Users
    class DevicesController < BaseController
      resource_description do
        name "Users::Devices"
        short "users' devices"
      end

      before_action :authenticate_api_auth_user!
      before_action :pundit_authorize

      api :POST,
          "/users/devices",
          "register user's device"
      param :uuid, String, required: true
      def create
        # TODO
      end
    end
  end
end
