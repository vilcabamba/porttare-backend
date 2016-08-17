# == Schema Information
#
# Table name: provider_items
#
#  id                  :integer          not null, primary key
#  provider_profile_id :integer
#  titulo              :string           not null
#  descripcion         :text
#  unidad_medida       :integer
#  precio_cents        :integer          default(0), not null
#  precio_currency     :string           default("USD"), not null
#  volumen             :string
#  peso                :string
#  imagen              :string
#  observaciones       :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :provider_item do
    provider_profile

    titulo        { Faker::Commerce.product_name }
    descripcion   { Faker::Company.catch_phrase }
    unidad_medida { ProviderItem::UNIDADES_MEDIDA.sample }
    precio        { Faker::Commerce.price }
    volumen       { Faker::Number.number(3) }
    peso          { "#{Faker::Number.number(3)} kg" }
    imagen        { Faker::Avatar.image(nil, "50x50") }
    observaciones { Faker::Hipster.paragraphs.join "\n" }
  end
end
