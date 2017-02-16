module Admin
  class PlacesController < BaseController
    include Admin::BaseController::Resourceable

    self.resource_type = "Place"

    def index
      pundit_authorize
      @resource_collection = resource_scope.sorted.decorate
    end

    def update
      super
    end

    private

    def resource_path
      { action: :index }
    end
  end
end
