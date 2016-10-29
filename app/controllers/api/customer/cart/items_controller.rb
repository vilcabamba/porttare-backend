module Api
  module Customer
    module Cart
      class ItemsController < Api::Customer::BaseController
        before_action :authenticate_api_auth_user!
        before_action :find_or_create_customer_profile,
                      except: :index
        before_action :find_or_create_current_order,
                      except: :index
        before_action :find_customer_order_item,
                      only: [:update, :destroy]
        before_action :pundit_authorize,
                      only: [:index, :create]

        resource_description do
          name "Customer::Cart::Items"
          short "current customer's items in cart"
          description "**NB.** this endpoint will render **full** customer order serialized in response as part of all actions"
        end

        api :GET,
            "/customer/cart",
            "Get current cart"
        desc "Returns current customer order or empty if there's no customer order. Each order item has a cached price which should be used as provider's item may change it's price"
        example %q{{
    "customer_order":{
      "id":1,
      "status":"in_progress",
      "subtotal_items_cents":44811,
      "customer_order_items":[{
        "id":1,
        "cantidad":9,
        "provider_item_precio_cents":4979,
        "observaciones":"Hella park cornhole mixtape brooklyn offal tumblr cardigan. Cred scenester vinegar fap trust fund aesthetic letterpress helvetica. Etsy salvia schlitz sriracha venmo. Meh forage umami messenger bag roof green juice.",
        "provider_item":{
          "id":1,
          "titulo":"Incredible Wool Hat",
          "descripcion":"flexibilidad asimétrica Totalmente configurable",
          "unidad_medida":"peso",
          "precio_cents":4979,
          "volumen":"945",
          "peso":"423 kg",
          "observaciones":"Dreamcatcher meggings thundercats tacos hella chillwave mlkshk. Banjo 8-bit wolf keytar freegan polaroid. Celiac park bicycle rights blue bottle pork belly.",
          "imagenes":[]
        }
      }
    }
  }}
        def index
          @customer_profile = current_api_auth_user.customer_profile
          if @customer_profile.present?
            @customer_order = @customer_profile.current_order
          end
          skip_policy_scope # because we access through #current_order
          render :customer_order
        end

        def_param_group :customer_order_item do
          param :cantidad,
                Integer,
                required: true,
                desc: "Cantidad de ítems a agregar al carrito"
          param :observaciones,
                String,
                desc: "Observaciones para el ítem. ej: sin cebolla"
        end

        api :POST,
            "/customer/cart/items",
            "Add an item to the cart"
        see "customer-cart-items#index", "Customer::Cart::Items#index for customer order serialization in response"
        param :provider_item_id,
              Integer,
              required: true,
              desc: "Ítem a agregar al carrito"
        param_group :customer_order_item
        def create
          @customer_order_item =
            @customer_order
              .order_items.new(customer_order_item_params)
          if @customer_order_item.save
            render :customer_order, status: :created
          else
            @errors = @customer_order_item.errors
            render "api/shared/resource_error",
                   status: :unprocessable_entity
          end
        end

        api :PUT,
            "/customer/cart/items/:id",
            "Update an item in the cart"
        see "customer-cart-items#index", "Customer::Cart::Items#index for customer order serialization in response"
        param :id,
              Integer,
              required: true,
              desc: "order item's id"
        param_group :customer_order_item
        def update
          authorize @customer_order_item
          if @customer_order_item.update(customer_order_item_params)
            # HACK force resetting @customer_order
            # as it's left stale because of caches and so
            @customer_order = @customer_order_item.customer_order
            render :customer_order, status: :accepted
          else
            @errors = @customer_order_item.errors
            render "api/shared/resource_error",
                   status: :unprocessable_entity
          end
        end

        api :DELETE,
            "/customer/cart/items/:id",
            "Remove an item from the cart"
        see "customer-cart-items#index", "Customer::Cart::Items#index for customer order serialization in response"
        param :id,
              Integer,
              required: true,
              desc: "order item's id"
        def destroy
          authorize @customer_order_item
          @customer_order_item.destroy
          render :customer_order, status: :accepted
        end

        private

        def pundit_authorize
          authorize CustomerOrderItem
        end

        def find_customer_order_item
          @customer_order_item = @customer_order.order_items.find(
            params[:id]
          )
        end

        def find_or_create_current_order
          skip_policy_scope # because we access through #current_order
          @customer_order =
            @customer_profile.current_order || @customer_profile.customer_orders.create
        end

        def customer_order_item_params
          params.permit(
            *policy(CustomerOrderItem).permitted_attributes
          )
        end
      end
    end
  end
end
