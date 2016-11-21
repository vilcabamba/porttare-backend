class ProviderProfile < ActiveRecord::Base
  module TransitionTo
    class AskToValidateService < GenericTransitionService
      def perform
        return unless valid?
        @provider_profile.transaction do
          @provider_profile.paper_trail_event = predicate
          if @provider_profile.update(status: predicate)
            ShippingRequest.create!(
              kind: predicate,
              resource: @provider_profile,
              address_attributes: address_attributes
            )
          end
        end
      end

      private

      def predicate
        :ask_to_validate
      end

      def perform_validations!
        unless main_office.present?
          errors << I18n.t(
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
end
