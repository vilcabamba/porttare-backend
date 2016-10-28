module Api
  module Customer
    class AddressesController < Customer::BaseController
      resource_description do
        name "Customer::Addresses"
        short "customer's address"
      end

      before_action :authenticate_api_auth_user!
      before_action :find_or_create_customer_profile,
                    except: :index
      before_action :find_customer_addresses,
                    only: [:update]
      before_action :pundit_authorize,
                    only: [:index, :create]

      api :GET,
          "/customer/addresses",
          "customer addresses"
      example %q{{
  "customer_addresses":[
    {
      "id":1,
      "ciudad":"Quito",
      "parroquia":"Quito",
      "barrio":"Cumbayá",
      "direccion_uno":"Calle Miguel Ángel",
      "direccion_dos":"Lorem Impusm",
      "codigo_postal":"124455",
      "numero_convencional":"2342-5678",
      "referencia":"Cerca a la cuchara, casa de 2 pisos amarilla"
    }
  ]}
}
      def index
        if current_api_auth_user.customer_profile
          @customer_addresses = customer_scope
        else
          skip_policy_scope
        end
      end

      def_param_group :customer_address do
        param :ciudad, String
        param :parroquia, String
        param :barrio, String
        param :direccion_uno, String
        param :direccion_dos, String
        param :codigo_postal, String
        param :referencia, String
        param :numero_convencional, String
      end

      api :POST,
          "/customer/addresses",
          "Create customer's address"
      param_group :customer_address
      def create
        @customer_address =
          customer_scope.new(customer_address_params)
        if @customer_address.save
          render :customer_address, status: :created
        else
          @errors = @customer_address.errors
          render "api/shared/resource_error",
                 status: :unprocessable_entity
        end
      end

      api :PUT,
          "/customer/addresses/:id",
          "Edit customer's address"
      param :id, Integer, required: true
      param_group :customer_address
      def update
        authorize @customer_address
        if @customer_address.update(customer_address_params)
          render :customer_address, status: :accepted
        else
          @errors = @customer_address.errors
          render "api/shared/resource_error",
                 status: :unprocessable_entity
        end
      end

      private

      def pundit_authorize
        authorize CustomerAddress
      end

      def find_customer_addresses
        @customer_address = customer_scope.find(params[:id])
      end

      def customer_address_params
        params.permit(
          *policy(CustomerAddress).permitted_attributes
        )
      end

      def customer_scope
        policy_scope(CustomerAddress)
      end
    end
  end
end
