module Api
  module Provider
    class BaseController < Api::BaseController
      before_action :verify_provider_is_active

      protected

      def verify_provider_is_active
        if pundit_user.provider_profile.status.disabled?
          raise Pundit::NotAuthorizedError.new(
            t("provider_profile.errors.disabled")
          )
        end
      end
    end
  end
end
