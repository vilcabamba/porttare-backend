module Api
  class RefersController < BaseController
    before_action :authenticate_api_auth_user!

    respond_to :json

    resource_description do
      short "refer user"
    end

    def index
    end

  end
end
