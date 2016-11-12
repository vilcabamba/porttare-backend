module Api
  module Provider
    class BaseController < Api::BaseController
      module ResourceCollectionable
        extend ActiveSupport::Concern

        included do
          before_action :pundit_authorize
        end

        def index
          @api_collection = resource_scope
        end
      end
    end
  end
end
