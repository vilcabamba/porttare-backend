module Admin
  class ProviderItemsController < BaseController
    include Admin::BaseController::Resourceable

    self.resource_type = "ProviderItem"

    def index
      pundit_authorize
      @resource_collection =
        resource_scope.includes(:imagenes,
                                :provider_profile,
                                :provider_item_category)
                      .page(params[:page])
                      .decorate
    end
  end
end
