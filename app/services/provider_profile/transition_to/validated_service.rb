class ProviderProfile < ActiveRecord::Base
  module TransitionTo
    class ValidatedService < GenericTransitionService
      def perform
        return unless valid?
        transaction do
          update_state!
        end
      end

      private

      def predicate
        :validated
      end

      def perform_validations!
        # TODO
      end
    end
  end
end
