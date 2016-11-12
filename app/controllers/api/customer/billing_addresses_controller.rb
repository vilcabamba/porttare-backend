module Api
  module Customer
    class BillingAddressesController < Customer::BaseController
      include Api::BaseController::Resourceable

      resource_description do
        name "Customer::BillingAddresses"
        short "customer's billing addresses"
      end

      before_action :authenticate_api_auth_user!
      before_action :find_or_create_customer_profile,
                    except: :index
      before_action :find_customer_billing_address,
                    only: [:update]
      before_action :pundit_authorize,
                    only: [:index, :create]

      api :GET,
          "/customer/billing_addresses",
          "customer billing addresses"
      example %q{{
  "customer_billing_addresses":[
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
      end

      def_param_group :customer_billing_address do
        param :ruc, String, required: true
        param :email, String
        param :ciudad, String
        param :telefono, String
        param :razon_social, String, required: true
      end

      api :POST,
          "/customer/billing_addresses",
          "Create a customer's billing address"
      param_group :customer_billing_address
      def create
        super
      end

      private

      def resource_klass
        CustomerBillingAddress
      end
    end
  end
end
