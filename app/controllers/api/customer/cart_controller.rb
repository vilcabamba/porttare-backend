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



      private


    end
  end
end
