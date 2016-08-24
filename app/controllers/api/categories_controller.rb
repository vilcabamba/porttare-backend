module Api
  class CategoriesController < BaseController
    before_action :authenticate_api_auth_user!

    respond_to :json

    def index
      @categories = public_scope.all
    end

    private

    def public_scope
      policy_scope(ProviderCategory)
    end
  end
end
