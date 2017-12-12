module Admin
  class CustomerOrderDeliveriesController < BaseController
    include Admin::BaseController::Resourceable

    self.resource_type = "CustomerOrderDelivery"

    def accept
      find_current_resource
      pundit_authorize
      service = CustomerOrder::ProviderResponse::AcceptService.new(
        @current_resource.object.provider_profile.user,
        @current_resource.object.customer_order,
        params[:customer_order_delivery]
      )
      if service.perform
        #continue with modals
        redirect_to(
          :back,
          notice: "accepted!"
        )
      else
        #show errors in form
        redirect_to(
          :back,
          error: "not accepted!"
        )
      end
    end

    def reject
      find_current_resource
      pundit_authorize
      service = CustomerOrder::ProviderResponse::RejectService.new(
        @current_resource.object.provider_profile.user,
        @current_resource.object.customer_order,
        params[:customer_order_delivery]
      )
      if service.perform
        #continue with modals
        redirect_to(
          :back,
          notice: "rejected!"
        )
      else
        #show errors in form
        redirect_to(
          :back,
          error: "not rejected!"
        )
      end
    end

    private
  end
end
