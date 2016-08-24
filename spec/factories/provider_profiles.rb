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
#  provider_category_id   :integer
#

FactoryGirl.define do
  factory :provider_profile do
    user

    ruc                    { Faker::Code.npi }
    email                  { Faker::Internet.email }
    telefono               { Faker::PhoneNumber.phone_number }
    razon_social           { Faker::Company.name }
    banco_nombre           { Faker::Team.name }
    actividad_economica    { Faker::Company.profession }
    representante_legal    { Faker::Name.name }
    banco_numero_cuenta    { Faker::Company.ein }
    fecha_inicio_actividad { Faker::Date.backward }
    banco_identificacion   { Faker::Company.duns_number }
    website                { Faker::Internet.url }
    facebook_handle        { Faker::Internet.user_name }
    twitter_handle         { Faker::Internet.user_name }
    instagram_handle       { Faker::Internet.user_name }
    youtube_handle         { Faker::Internet.user_name }
    mejor_articulo         { Faker::Hipster.paragraphs.join "\n" }
    formas_de_pago         { ProviderProfile::FORMAS_DE_PAGO.sample(1) }
    tipo_contribuyente {
      [
        "Personal natural"
      ].sample
    }
  end
end
