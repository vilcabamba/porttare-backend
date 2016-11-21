class ProviderProfile < ActiveRecord::Base
  module TransitionTo
    class ValidatedService < GenericTransitionService

    end
  end
end
