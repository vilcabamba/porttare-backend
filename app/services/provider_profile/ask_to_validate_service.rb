class ProviderProfile < ActiveRecord::Base
  class AskToValidateService
    def initialize(provider_profile, predicate)
      @provider_profile = provider_profile
      @predicate = predicate
    end

    def perform
      return unless valid?
      @provider_profile.paper_trail_event = @predicate
      if @provider_profile.update(status: @predicate)
        ShippingRequest.create!(
          kind: @predicate,
          resource: @provider_profile,
          address_attributes: address_attributes
        )
      end
    end

    def notice
      I18n.t(
        "admin.provider_profile.transition.to.#{@predicate}"
      )
    end

    def valid?
      main_office.present?
    end

    private

    def main_office
      @main_office ||= @provider_profile.offices.first
    end

    def address_attributes
      main_office.attributes.slice(
        "ciudad",
        "telefono",
        "direccion"
      )
    end
  end
end
