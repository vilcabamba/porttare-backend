module Admin
  class ProvidersController < BaseController
    include Admin::BaseController::Resourceable

    self.resource_type = "ProviderProfile"

    before_action :find_current_resource, only: :transition
    before_action :pundit_authorize, only: :transition

    def index
      pundit_authorize
      @resource_status = params[:status] || ProviderProfile.status.values.first
      @resource_collection = resource_scope.with_status(
        @resource_status
      ).includes(:provider_category).decorate
    end

    def show
      super
      @resource_status = @current_resource.status
    end

    def transition
      transitor = ProviderProfile::TransitorService.new(
        @current_resource,
        params[:predicate]
      ).perform!
      redirect_to(
        { action: :show, id: params[:id] },
        transitor.flashes
      )
    end
  end
end
