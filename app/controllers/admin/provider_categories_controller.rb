module Admin
  class ProviderCategoriesController < BaseController
    include Admin::BaseController::Resourceable

    self.resource_type = "ProviderCategory"

    def index
      pundit_authorize
      @resource_status = params[:status] || ProviderCategory.status.values.first
      @resource_collection = resource_scope.with_status(
        @resource_status
      ).decorate
    end
  end
end
