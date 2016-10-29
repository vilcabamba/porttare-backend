# == Schema Information
#
# Table name: provider_offices
#
#  id                  :integer          not null, primary key
#  provider_profile_id :integer          not null
#  enabled             :boolean          default(FALSE)
#  direccion           :string           not null
#  ciudad              :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  telefono            :string
#  hora_de_apertura    :time
#  hora_de_cierre      :time
#  inicio_de_labores   :string
#  final_de_labores    :string
#

require "porttare_backend/places"

class ProviderOffice < ActiveRecord::Base
  DAY_NAMES = Date::DAYNAMES.map(&:downcase)

  begin :relationships
    belongs_to :provider_profile
    has_many :provider_dispatchers,
             dependent: :destroy
  end

  begin :validations
    validates :direccion,
              :hora_de_apertura,
              :hora_de_cierre,
              :telefono,
              presence: true
    validates :inicio_de_labores,
              :final_de_labores,
              inclusion: { in: DAY_NAMES }
    validates :ciudad,
              inclusion: { in: PorttareBackend::Places.all }
  end

  scope :enabled, -> { where(enabled: true) }

  [
    :hora_de_cierre,
    :hora_de_apertura
  ].each do |attribute_name|
    define_method "#{attribute_name}=" do |new_time|
      schedule_format = I18n.t("time.formats.office_schedule")
      send(
        :write_attribute,
        attribute_name,
        DateTime.strptime(new_time, schedule_format)
      )
    end
  end
end
