class ProviderProfile < ActiveRecord::Base
  module TransitionTo
    class GenericTransitionService
      def initialize(provider_profile)
        @provider_profile = provider_profile
      end

      def flashes
        if valid?
          {
            success: I18n.t(
              "admin.provider_profile.transition.to.#{predicate}"
            )
          }
        else
          {
            error: I18n.t("admin.something_went_wrong") + ": " + errors.join(", ")
          }
        end
      end

      def valid?
        if errors.empty?
          perform_validations!
        end
        errors.empty?
      end

      private

      def errors
        @errors ||= []
      end
    end
  end
end
