module Api
  module Customer
    class ProfilesController < BaseController
      resource_description do
        name "Customer::Profiles"
        short "apply for a customer profile"
      end

      before_action :authenticate_api_auth_user!
      before_action :find_or_create_customer_profile, only: [:show]

      api :GET,
          "/customer/profile",
          "Customer's profile"
      example %q{{
  "customer_profile":{
    "id":1,
    "user_id":1,
    "name": 'Sebastian López',
    "email":"sebastian@lopez.com",
    "ciudad": 'Quito',
    "fecha_de_nacimiento":"1990/12/03",
    "customer_addresses": [{
      "id":1,
      "ciudad":"Quito",
      "parroquia":"Quito",
      "barrio":"Cumbayá",
      "direccion_uno":"Calle Miguel Ángel",
      "direccion_dos":"Lorem Impusm",
      "codigo_postal":"124455",
      "referencia":"La Primavera",
      "numero_convencional":"2342-5678"
    }]
  }
}}
      def show
      end

      api :PUT,
          "/customer/profile",
          "Edit customer's profile"
      param :id, Integer, required: true

      def update
        @user = current_api_auth_user
        if @user.update(customer_profile_params)
          render :customer_profile, status: :accepted
        else
          @errors = @user.errors
          render "api/shared/resource_error",
                 status: :unprocessable_entity
        end
      end

      private

      def find_or_create_customer_profile
        @customer_profile =
          current_api_auth_user.customer_profile || current_api_auth_user.build_customer_profile
      end

      def customer_profile_params
        params.permit(
          *policy(CustomerProfile).permitted_attributes
        )
      end
    end
  end
end
