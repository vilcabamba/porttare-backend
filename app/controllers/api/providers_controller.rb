module Api
  class ProvidersController < BaseController
    respond_to :json

    before_action :authenticate_api_auth_user!
    before_action :find_provider_category,
                  only: [:index, :show]

    resource_description do
      short "providers from a category"
    end

    api :GET,
        "/categories/:category_id/providers",
        "List of providers that belong to a category"
    desc "includes full provider info"
    param :category_id, Integer, required: true
    example %q{{
  "provider_category":{
    "id":1,
    "titulo":"Tools",
    "imagen":"https://robohash.org/sapientesuntdelectus.png?size=400x600&set=set1",
    "descripcion":"Bushwick pug tote bag sriracha forage pinterest retro direct trade yr.",
    "provider_profiles":[
      {
        "id":1,
        "ruc":"3696402456",
        "razon_social":"Mendoza,
         Molina y Moreno Asociados",
        "nombre_establecimiento":"Almonte y Peralta",
        "actividad_economica":"advocate",
        "representante_legal":"Lorena Montenegro Cisneros",
        "telefono":"979-520-588",
        "email":"lora@andersonullrich.org",
        "website":"http://stamm.co/domenica.mante",
        "formas_de_pago":["efectivo"],
        "logotipo_url":null,
        "facebook_handle":"emilie",
        "twitter_handle":"billie",
        "instagram_handle":"nellie.douglas",
        "youtube_handle":"dennis",
        "provider_offices":[
          {
            "id":1,
            "direccion":"Caserio Marilu,
             6 Puerta 639",
            "ciudad":"Torrejón de Ardoz",
            "horario":"10:00 AM - 7:00 PM"
          }
        ]
      }
    ]
  }
}}
    def index
    end

    api :GET,
        "/categories/:category_id/providers/:id",
        "Provider information"
    desc "includes full products info"
    example %q{{
  "provider":{
    "id":2,
    "nombre_establecimiento":"Perea S.L.",
    "telefono":"946 381 185",
    "email":"titus.wiegand@walker.org",
    "offices":[
      {
        "id":2,
        "direccion":"Barrio Emilia 9",
        "ciudad":"Gecho",
        "horario":"10:00 AM - 7:00 PM",
        "enabled":false
      }
    ]
    "products":[
      {
        "id":1,
        "titulo":"Rustic Silk Pants",
        "descripcion":"data-warehouse 4th generación Orígenes",
        "unidad_medida":"volumen",
        "precio_cents":4079,
        "volumen":"798",
        "peso":"986 kg",
        "observaciones":"Marfa 90's xoxo shoreditch. Selvage butcher trust fund. Pickled polaroid echo hammock.\nKickstarter stumptown gastropub",
        "created_at":"2016-08-17T17:21:04.569-05:00",
        "updated_at":"2016-08-17T17:21:04.569-05:00",
        "imagenes":[
          {
            "id":1,
            "imagen_url":"https://robohash.org/aliquamdelenitiquisquam.png?size=50x50\u0026set=set1"
          }
        ]
      }
    ]
  }
}}
    param :category_id, Integer, required: true
    param :id, Integer, required: true
    def show
      @provider = @category.provider_profiles.find(params[:id])
    end

    private

    def provider_category_scope
      policy_scope(ProviderCategory)
    end

    def find_provider_category
      @provider_category = provider_category_scope.find(params[:category_id])
    end
  end
end
