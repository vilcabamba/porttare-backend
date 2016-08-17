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

class ProviderItem < ActiveRecord::Base
  UNIDADES_MEDIDA = [
    "volumen",
    "unidades",
    "peso",
    "longitud"
  ].freeze

  enum unidad_medida: UNIDADES_MEDIDA

  belongs_to :provider_profile

  validates :titulo,
            presence: true
  validates :precio,
            numericality: { greater_than: 0 }
  validates :unidad_medida,
            inclusion: { in: UNIDADES_MEDIDA }

  monetize :precio_cents,
           numericality: false
end
