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

class ProviderProfile < ActiveRecord::Base
  FORMAS_DE_PAGO = [
    "efectivo",
    "tarjeta_credito"
  ].freeze

  belongs_to :user
  has_many :provider_items

  validates :ruc,
            :razon_social,
            :actividad_economica,
            :telefono,
            :email,
            :banco_nombre,
            :banco_numero_cuenta,
            :banco_identificacion,
            presence: true
  validates :ruc, uniqueness: true
  validate :validate_formas_de_pago

  private

  def validate_formas_de_pago
    all_valid = formas_de_pago.all? do |forma_de_pago|
      FORMAS_DE_PAGO.include?(forma_de_pago)
    end
    errors.add(:formas_de_pago, :invalid) unless all_valid
  end
end
