module Api
  class InvitationsController < BaseController
    before_action :authenticate_api_auth_user!

    respond_to :json

    resource_description do
      short "send an invitation to friend"
    end

    def index
    end

  end
end
