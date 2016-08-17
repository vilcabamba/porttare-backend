# == Schema Information
#
# Table name: provider_items
#
#  id                  :integer          not null, primary key
#  provider_profile_id :integer
#  titulo              :string           not null
#  descripcion         :text
#  unidad_medida       :integer
#  precio              :money            not null
#  volumen             :string
#  peso                :string
#  imagen              :string
#  observaciones       :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ProviderItem < ActiveRecord::Base
  belongs_to :provider_profile

  validates :titulo,
            presence: true
  monetize :precio_cents
  validates :precio_cents,
            numericality: { greater_than_or_equal_to: 0 }
end
