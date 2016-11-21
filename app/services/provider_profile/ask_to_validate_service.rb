class ProviderProfile < ActiveRecord::Base
  class AskToValidateService
    PREDICATE = :ask_to_validate

    def initialize(provider_profile)
      @errors = []
      @provider_profile = provider_profile
    end

    def perform
      return unless valid?
      @provider_profile.transaction do
        @provider_profile.paper_trail_event = PREDICATE
        if @provider_profile.update(status: PREDICATE)
          ShippingRequest.create!(
            kind: PREDICATE,
            resource: @provider_profile,
            address_attributes: address_attributes
          )
        end
      end
    end

    def flashes
      if valid?
        {
          success: I18n.t(
            "admin.provider_profile.transition.to.#{PREDICATE}"
          )
        }
      else
        {
          error: I18n.t("admin.something_went_wrong") + ": " + @errors.join(", ")
        }
      end
    end

    def valid?
      if @errors.empty?
        validate_main_office
      end
      @errors.empty?
    end

    private

    def validate_main_office
      unless main_office.present?
        @errors << I18n.t(
          "admin.provider_profile.transition.error.office_required"
        )
      end
    end

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
