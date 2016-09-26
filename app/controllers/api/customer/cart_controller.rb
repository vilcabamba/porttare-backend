module Api
  module Customer
    class CartController < BaseController
      resource_description do
        name "Customer::Cart"
        short "current customer's cart"
      end

      before_action :authenticate_api_auth_user!
      before_action :find_customer_profile
      before_action :find_current_order

      api :POST,
          "/api/customer/cart",
          "Add items to the cart"
      param :cantidad,
            Integer,
            required: true,
            desc: "Cantidad de ítems a agregar al carrito"
      param :provider_item_id,
            Integer,
            required: true,
            desc: "Ítem a agregar al carrito"
      param :observaciones,
            String,
            desc: "Observaciones para el ítem. ej: sin cebolla"
      example %q{{
  "customer_order":{
    "id":1,
    "status":"in_progress",
    "subtotal_items_cents":399,
    "customer_order_items":[{
      "cantidad":7,
      "provider_item_id":1,
      "observaciones":"Gastropub neutra leggings tumblr. Disrupt heirloom waistcoat. Leggings brooklyn twee pinterest etsy vhs.\nHoodie raw denim scenester pop-up gastropub church-key. Pickled sustainable tattooed bushwick vhs tofu distillery wayfarers. Vegan shoreditch pug jean shorts shabby chic fixie banh mi.\nChurch-key fashion axe williamsburg. Pug semiotics single-origin coffee portland tilde butcher banh mi next level. Occupy synth hoodie gentrify pug organic. Celiac viral schlitz."
    }]
  }
}}
      def create
        @customer_order_item =
          @customer_order
            .order_items.new(order_items_params)
        if @customer_order_item.save
          render :customer_order, status: :created
        else
          @errors = @customer_order_item.errors
          render "api/shared/resource_error",
                 status: :unprocessable_entity
        end
      end

      private

      def find_customer_profile
        @customer_profile = current_api_auth_user.customer_profile || current_api_auth_user.create_customer_profile
      end

      def find_current_order
        @customer_order = @customer_profile.current_order
      end

      def order_items_params
        params.permit(
          *policy(CustomerOrderItem).permitted_attributes
        )
      end
    end
  end
end
