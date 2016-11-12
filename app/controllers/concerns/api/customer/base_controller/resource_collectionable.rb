module Api
  module Customer
    class BaseController < Api::BaseController
      module ResourceCollectionable
        def index
          pundit_authorize
          if current_api_auth_user.customer_profile
            @api_collection = resource_scope
          else
            skip_policy_scope
          end
        end
      end
    end
  end
end
