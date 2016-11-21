class ProviderProfile < ActiveRecord::Base
  class TransitorService
    def initialize(resource, predicate)
      @predicate = predicate
      @transitor = resource_klass.new(resource)
    end

    ##
    # @return self
    def perform!
      @transitor.perform
      self
    end

    delegate :flashes, to: :@transitor

    private

    def resource_klass
      (
        "ProviderProfile::" + @predicate.classify + "Service"
      ).constantize
    end
  end
end
