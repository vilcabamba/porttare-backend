module Admin
  class ShippingRequestsController < BaseController
    include Admin::BaseController::Resourceable

    self.resource_klass = ShippingRequest

    def index
      super
    end
  end
end
