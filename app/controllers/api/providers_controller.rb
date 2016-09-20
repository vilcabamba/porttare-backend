module Api
  class ProvidersController < BaseController
    before_action :authenticate_api_auth_user!

    respond_to :json

    api :GET,
        "/categories/:category_id/providers",
        "Category information with a list of providers"
    example %q{{
  "id":2,
  "titulo":"Alimentos preparados",
  "imagen":"https://robohash.org/veniameanostrum.png?size=400x600\u0026set=set1",
  "descripcion":"Carry mustache twee brooklyn.",
  "providers":[
    {
      "id":2,
      "razon_social":"Perea S.L."
    }
  ]
}}
    param :category_id, Integer, required: true
    def index
      @category = public_scope.find(params[:category_id])
    end

    private

    def public_scope
      policy_scope(ProviderCategory)
    end
  end
end
