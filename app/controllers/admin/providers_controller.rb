module Admin
  class ProvidersController < BaseController
    include Admin::BaseController::Resourceable

    self.resource_klass = ProviderProfile

    before_action :find_current_resource, only: :transition

    def index
      @resource_status = params[:status] || resource_klass.status.values.first
      @resource_collection = resource_scope.with_status(
        @resource_status
      ).decorate
    end

    def show
      super
    end

    def transition
      transitor = ProviderProfile::AskToValidateService.new(
        @current_resource,
        params[:predicate]
      )
      transitor.perform
      redirect_to(
        { action: :show, id: params[:id] },
        transitor.flashes
      )
    end
  end
end
