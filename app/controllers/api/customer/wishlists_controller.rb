module Api
  module Customer
    class WishlistsController < BaseController
      before_action :authenticate_api_auth_user!
      before_action :find_or_create_customer_profile

      resource_description do
        name "Customer::Wishlists"
        short "current customer's wishlists"
      end

      api :POST,
          "/customer/wishlists",
          "create a wishlist"
      param :nombre,
            String,
            required: true,
            desc: "Nombre para identificar la lista"
      param :entregar_en,
            Time,
            "Permite especificar al cliente la fecha y hora de entrega deseada"
      param :provider_items_ids,
            Array,
            "Arreglo con los ítems que pertenecen a la lista"
      def create
        @customer_wishlist =
          @customer_profile
            .customer_wishlists.new(customer_wishlist_params)
        if @customer_wishlist.save
          render :customer_wishlist, status: :created
        else
          @errors = @customer_wishlist.errors
          render "api/shared/resource_error",
                 status: :unprocessable_entity
        end
      end

      private

      def customer_wishlist_params
        params.permit(
          *policy(CustomerWishlist).permitted_attributes
        )
      end
    end
  end
end
