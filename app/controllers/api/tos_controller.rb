module Api
  class TosController < BaseController
    respond_to :json

    resource_description do
      name "Tos"
      short "Terms of Service"
    end

    api :GET,
        "/tos",
        "Read TOS"
    def show
      skip_policy_scope
      skip_authorization
    end

    private

    def api_resource
      SitePreference.by_key("tos")
    end
    helper_method :api_resource
  end
end
