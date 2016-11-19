class ProviderProfile < ActiveRecord::Base
  class AskToValidateService
    def initialize(provider_profile, predicate)
      @provider_profile = provider_profile
      @predicate = predicate
    end

    def perform
      @provider_profile.paper_trail_event = @predicate
      @provider_profile.update!(status: @predicate)
    end

    def notice
      I18n.t(
        "admin.provider_profile.transition.to.#{@predicate}"
      )
    end
  end
end
