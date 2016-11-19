class ProviderProfile < ActiveRecord::Base
  class AskToValidateService
    def initialize(provider_profile, predicate)
      @provider_profile = provider_profile
      @predicate = predicate
    end

    def perform
      @provider_profile.paper_trail_event = @predicate
      if @provider_profile.update(status: @predicate)
        ShippingRequest.create!(
          kind: @predicate,
          resource: @provider_profile
        )
      end
    end

    def notice
      I18n.t(
        "admin.provider_profile.transition.to.#{@predicate}"
      )
    end
  end
end
