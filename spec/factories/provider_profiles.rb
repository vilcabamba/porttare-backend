# == Schema Information
#
# Table name: provider_profiles
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  ruc                    :string
#  razon_social           :string
#  actividad_economica    :string
#  tipo_contribuyente     :string
#  representante_legal    :string
#  telefono               :string
#  email                  :string
#  fecha_inicio_actividad :date
#  banco_nombre           :string
#  banco_numero_cuenta    :string
#  banco_identificacion   :string
#  website                :string
#  facebook_handle        :string
#  twitter_handle         :string
#  instagram_handle       :string
#  youtube_handle         :string
#  mejor_articulo         :text
#  formas_de_pago         :text             default([]), is an Array
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

FactoryGirl.define do
  factory :provider_profile do
    user

    ruc                    { Forgery('russian_tax').person_inn }
    email                  { Forgery('internet').email_address }
    telefono               { Forgery('address').phone }
    razon_social           { Forgery('name').company_name }
    banco_nombre           { Forgery('address').street_name }
    actividad_economica    { Forgery('name').industry }
    representante_legal    { Forgery('name').full_name }
    banco_numero_cuenta    { Forgery('russian_tax').account_number }
    fecha_inicio_actividad { Forgery('date').date }
    banco_identificacion   { Forgery('russian_tax').legal_inn }
    website                { Forgery('internet').domain_name }
    facebook_handle        { Forgery('internet').user_name }
    twitter_handle         { Forgery('internet').user_name }
    instagram_handle       { Forgery('internet').user_name }
    youtube_handle         { Forgery('internet').user_name }
    mejor_articulo         { Forgery('lorem_ipsum').paragraphs }
    formas_de_pago         { ProviderProfile::FORMAS_DE_PAGO.sample }
    tipo_contribuyente {
      [
        "Personal natural"
      ].sample
    }
  end
end
