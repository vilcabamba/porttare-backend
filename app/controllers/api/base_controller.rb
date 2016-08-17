module Api
  class BaseController < ::ApplicationController
    include JsonRequestsForgeryBypass
    include DeviseTokenAuth::Concerns::SetUserByToken

    alias_method :pundit_user, :current_api_auth_user

    private

    def user_not_authorized
      render json: { error: I18n.t("pundit.not_authorized") },
             status: :unauthorized
    end
  end
end
